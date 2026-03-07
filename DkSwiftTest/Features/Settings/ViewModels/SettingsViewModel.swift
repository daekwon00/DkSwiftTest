import SwiftUI

@Observable
final class SettingsViewModel {
    @ObservationIgnored
    @AppStorage("isDarkMode") var isDarkMode = false
    @ObservationIgnored
    @AppStorage("fontSize") var fontSize: Double = 16.0
    @ObservationIgnored
    @AppStorage("themeColor") var themeColorName = "blue"
    @ObservationIgnored
    @AppStorage("profileData") var profileData: Data = {
        (try? JSONEncoder().encode(UserProfile.default)) ?? Data()
    }()

    var showingProfileSheet = false
    var showingResetAlert = false

    var profile: UserProfile {
        get { (try? JSONDecoder().decode(UserProfile.self, from: profileData)) ?? .default }
        set { profileData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }

    static let availableColors: [(name: String, color: Color)] = [
        ("blue", .blue), ("purple", .purple), ("green", .green),
        ("orange", .orange), ("red", .red), ("pink", .pink)
    ]

    var selectedColor: Color {
        Self.availableColors.first { $0.name == themeColorName }?.color ?? .blue
    }

    func resetAll() {
        isDarkMode = false
        fontSize = 16.0
        themeColorName = "blue"
        profileData = (try? JSONEncoder().encode(UserProfile.default)) ?? Data()
    }
}
