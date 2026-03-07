import SwiftUI

enum ShowcaseItem: String, CaseIterable, Identifiable {
    case buttons = "Button 스타일"
    case lists = "List 스타일"
    case forms = "Form 컴포넌트"
    case alertSheet = "Alert & Sheet"
    case animation = "Animation"
    case charts = "Swift Charts"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .buttons: "hand.tap"
        case .lists: "list.bullet"
        case .forms: "doc.text"
        case .alertSheet: "bell"
        case .animation: "sparkles"
        case .charts: "chart.bar"
        }
    }
}

struct ShowcaseListView: View {
    var body: some View {
        NavigationStack {
            List(ShowcaseItem.allCases) { item in
                NavigationLink(value: item) {
                    Label(item.rawValue, systemImage: item.icon)
                }
            }
            .navigationTitle("UI 쇼케이스")
            .navigationDestination(for: ShowcaseItem.self) { item in
                switch item {
                case .buttons: ButtonShowcase()
                case .lists: ListShowcase()
                case .forms: FormShowcase()
                case .alertSheet: AlertSheetShowcase()
                case .animation: AnimationShowcase()
                case .charts: ChartShowcase()
                }
            }
        }
    }
}
