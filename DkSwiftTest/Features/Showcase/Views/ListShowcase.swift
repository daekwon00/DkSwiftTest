import SwiftUI

struct ListShowcase: View {
    @State private var selectedStyle = 0
    private let fruits = ["사과", "바나나", "체리", "포도", "키위", "망고", "오렌지"]

    var body: some View {
        VStack(spacing: 0) {
            Picker("스타일", selection: $selectedStyle) {
                Text("Inset").tag(0)
                Text("Grouped").tag(1)
                Text("Plain").tag(2)
                Text("Sidebar").tag(3)
            }
            .pickerStyle(.segmented)
            .padding()

            switch selectedStyle {
            case 0:
                List(fruits, id: \.self) { fruit in
                    Label(fruit, systemImage: "leaf")
                }
                .listStyle(.insetGrouped)
            case 1:
                List(fruits, id: \.self) { fruit in
                    Label(fruit, systemImage: "leaf")
                }
                .listStyle(.grouped)
            case 2:
                List(fruits, id: \.self) { fruit in
                    Label(fruit, systemImage: "leaf")
                }
                .listStyle(.plain)
            default:
                List(fruits, id: \.self) { fruit in
                    Label(fruit, systemImage: "leaf")
                }
                .listStyle(.sidebar)
            }
        }
        .navigationTitle("List 스타일")
    }
}
