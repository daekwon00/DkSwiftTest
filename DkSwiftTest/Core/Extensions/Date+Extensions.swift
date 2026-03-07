import Foundation

extension Date {
    var formatted_yyyyMMdd: String {
        formatted(.dateTime.year().month(.twoDigits).day(.twoDigits))
    }

    var formatted_relative: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: .now)
    }

    var isOverdue: Bool {
        self < .now
    }
}
