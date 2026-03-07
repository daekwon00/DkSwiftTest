import Foundation

@Observable
final class PostListViewModel {
    var posts: [Post] = []
    var searchText = ""
    var isLoading = false
    var error: AppError?

    var filteredPosts: [Post] {
        if searchText.isEmpty { return posts }
        return posts.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.body.localizedCaseInsensitiveContains(searchText)
        }
    }

    func fetchPosts() async {
        isLoading = true
        error = nil
        do throws(AppError) {
            posts = try await NetworkService.shared.fetch([Post].self, from: "https://jsonplaceholder.typicode.com/posts")
        } catch {
            self.error = error
        }
        isLoading = false
    }

    func fetchComments(for postId: Int) async -> [Comment] {
        (try? await NetworkService.shared.fetch([Comment].self, from: "https://jsonplaceholder.typicode.com/posts/\(postId)/comments") as [Comment]) ?? []
    }

    func fetchUser(id: Int) async -> User? {
        try? await NetworkService.shared.fetch(User.self, from: "https://jsonplaceholder.typicode.com/users/\(id)") as User
    }
}
