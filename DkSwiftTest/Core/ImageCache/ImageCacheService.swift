import SwiftUI

@Observable
final class ImageCacheService {
    static let shared = ImageCacheService()
    private let cache = NSCache<NSString, UIImage>()
    private var activeTasks: [String: Task<UIImage?, Never>] = [:]

    private init() {
        cache.countLimit = 100
    }

    func image(for urlString: String) async -> UIImage? {
        if let cached = cache.object(forKey: urlString as NSString) {
            return cached
        }

        if let existing = activeTasks[urlString] {
            return await existing.value
        }

        let task = Task<UIImage?, Never> {
            guard let url = URL(string: urlString),
                  let (data, _) = try? await URLSession.shared.data(from: url),
                  let image = UIImage(data: data) else {
                return nil
            }
            cache.setObject(image, forKey: urlString as NSString)
            return image
        }

        activeTasks[urlString] = task
        let result = await task.value
        activeTasks.removeValue(forKey: urlString)
        return result
    }
}

struct CachedImageView: View {
    let urlString: String
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .overlay {
                        ProgressView()
                    }
            }
        }
        .task {
            image = await ImageCacheService.shared.image(for: urlString)
        }
    }
}
