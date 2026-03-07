import SwiftUI
import SwiftData

struct AddTodoSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var note = ""
    @State private var priority: TodoItem.Priority = .medium
    @State private var dueDate: Date = .now

    var body: some View {
        NavigationStack {
            Form {
                Section("기본 정보") {
                    TextField("제목", text: $title)
                    TextField("메모", text: $note, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("설정") {
                    Picker("우선순위", selection: $priority) {
                        ForEach(TodoItem.Priority.allCases) { p in
                            Text(p.label).tag(p)
                        }
                    }
                    DatePicker("마감일", selection: $dueDate, displayedComponents: .date)
                }
            }
            .navigationTitle("새 할 일")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("추가") {
                        let item = TodoItem(title: title, note: note, priority: priority, dueDate: dueDate)
                        modelContext.insert(item)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
