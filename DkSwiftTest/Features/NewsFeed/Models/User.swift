import Foundation

nonisolated struct User: Codable, Identifiable, Sendable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
