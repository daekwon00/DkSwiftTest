import Foundation

nonisolated struct Comment: Codable, Identifiable, Sendable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
