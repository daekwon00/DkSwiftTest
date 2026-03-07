import Foundation
import SwiftData

@Model
final class TodoItem {
    var title: String
    var note: String
    var priority: Priority
    var dueDate: Date
    var isCompleted: Bool
    var createdAt: Date

    init(title: String, note: String = "", priority: Priority = .medium, dueDate: Date = .now, isCompleted: Bool = false) {
        self.title = title
        self.note = note
        self.priority = priority
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.createdAt = .now
    }

    enum Priority: Int, Codable, CaseIterable, Identifiable {
        case low = 0
        case medium = 1
        case high = 2

        var id: Int { rawValue }

        var label: String {
            switch self {
            case .low: "낮음"
            case .medium: "보통"
            case .high: "높음"
            }
        }

        var color: String {
            switch self {
            case .low: "green"
            case .medium: "orange"
            case .high: "red"
            }
        }
    }
}
