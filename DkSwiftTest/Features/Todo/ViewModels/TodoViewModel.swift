import SwiftUI
import SwiftData

@Observable
final class TodoViewModel {
    var showingAddSheet = false
    var filterOption: FilterOption = .all
    var sortOption: SortOption = .createdAt

    enum FilterOption: String, CaseIterable {
        case all = "전체"
        case active = "미완료"
        case completed = "완료"
    }

    enum SortOption: String, CaseIterable {
        case createdAt = "생성일"
        case dueDate = "마감일"
        case priority = "우선순위"
    }

    func filteredAndSorted(_ items: [TodoItem]) -> [TodoItem] {
        let filtered: [TodoItem]
        switch filterOption {
        case .all: filtered = items
        case .active: filtered = items.filter { !$0.isCompleted }
        case .completed: filtered = items.filter { $0.isCompleted }
        }

        return filtered.sorted { a, b in
            switch sortOption {
            case .createdAt: a.createdAt > b.createdAt
            case .dueDate: a.dueDate < b.dueDate
            case .priority: a.priority.rawValue > b.priority.rawValue
            }
        }
    }
}
