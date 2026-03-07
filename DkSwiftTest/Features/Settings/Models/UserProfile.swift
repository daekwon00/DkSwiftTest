import Foundation

struct UserProfile: Codable {
    var name: String
    var email: String

    static let `default` = UserProfile(name: "사용자", email: "user@example.com")
}
