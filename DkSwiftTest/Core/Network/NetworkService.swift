import Foundation

struct NetworkService: Sendable {
    static let shared = NetworkService()
    private let session: URLSession

    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        session = URLSession(configuration: config)
    }

    nonisolated func fetch<T: Decodable & Sendable>(_ type: T.Type, from urlString: String) async throws(AppError) -> T {
        guard let url = URL(string: urlString) else {
            throw .network(URLError(.badURL))
        }

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(from: url)
        } catch let error as URLError {
            throw .network(error)
        } catch {
            throw .unknown(error)
        }

        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw .server(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw .decode(error)
        } catch {
            throw .unknown(error)
        }
    }
}
