import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TodoItem.createdAt, order: .reverse) private var allItems: [TodoItem]
    @State private var viewModel = TodoViewModel()

    var body: some View {
        NavigationStack {
            Group {
                let items = viewModel.filteredAndSorted(allItems)
                if items.isEmpty && allItems.isEmpty {
                    ContentUnavailableView("할 일이 없습니다",
                        systemImage: "checklist",
                        description: Text("+ 버튼을 눌러 새 할 일을 추가하세요"))
                } else if items.isEmpty {
                    ContentUnavailableView("결과 없음",
                        systemImage: "line.3.horizontal.decrease.circle",
                        description: Text("필터 조건에 맞는 항목이 없습니다"))
                } else {
                    List {
                        ForEach(items) { item in
                            TodoRow(item: item)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        modelContext.delete(item)
                                    } label: {
                                        Label("삭제", systemImage: "trash")
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        item.isCompleted.toggle()
                                    } label: {
                                        Label(item.isCompleted ? "미완료" : "완료",
                                              systemImage: item.isCompleted ? "arrow.uturn.backward" : "checkmark")
                                    }
                                    .tint(item.isCompleted ? .orange : .green)
                                }
                        }
                    }
                }
            }
            .navigationTitle("할 일")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("필터", selection: $viewModel.filterOption) {
                            ForEach(TodoViewModel.FilterOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        Picker("정렬", selection: $viewModel.sortOption) {
                            ForEach(TodoViewModel.SortOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Label("필터", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddSheet) {
                AddTodoSheet()
            }
        }
    }
}

struct TodoRow: View {
    let item: TodoItem

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .gray)
                .font(.title3)

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .strikethrough(item.isCompleted)
                    .foregroundStyle(item.isCompleted ? .secondary : .primary)

                HStack(spacing: 8) {
                    Text(item.priority.label)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(priorityColor.opacity(0.2), in: Capsule())
                        .foregroundStyle(priorityColor)

                    Text(item.dueDate.formatted_yyyyMMdd)
                        .font(.caption2)
                        .foregroundStyle(item.dueDate.isOverdue && !item.isCompleted ? .red : .secondary)
                }
            }
        }
        .padding(.vertical, 2)
    }

    private var priorityColor: Color {
        switch item.priority {
        case .low: .green
        case .medium: .orange
        case .high: .red
        }
    }
}
