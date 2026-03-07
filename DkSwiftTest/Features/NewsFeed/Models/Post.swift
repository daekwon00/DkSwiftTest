import Foundation

nonisolated struct Post: Codable, Identifiable, Sendable {
    let userId: Int
    let id: Int
    let title: String
    let body: String

    var thumbnailURL: String {
        "https://picsum.photos/id/\(id % 100)/200/200"
    }
}
