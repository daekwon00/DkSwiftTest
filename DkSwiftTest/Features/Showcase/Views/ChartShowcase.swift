import SwiftUI
import Charts

struct ChartShowcase: View {
    @State private var selectedChart = 0

    private let salesData: [(month: String, value: Double)] = [
        ("1월", 45), ("2월", 62), ("3월", 78), ("4월", 55),
        ("5월", 89), ("6월", 95), ("7월", 72), ("8월", 83)
    ]

    private let categoryData: [(category: String, value: Double)] = [
        ("iOS", 40), ("Android", 30), ("Web", 20), ("기타", 10)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Picker("차트", selection: $selectedChart) {
                    Text("Bar").tag(0)
                    Text("Line").tag(1)
                    Text("Pie").tag(2)
                }
                .pickerStyle(.segmented)

                switch selectedChart {
                case 0:
                    GroupBox("월별 매출") {
                        Chart(salesData, id: \.month) { item in
                            BarMark(
                                x: .value("월", item.month),
                                y: .value("매출", item.value)
                            )
                            .foregroundStyle(.blue.gradient)
                            .cornerRadius(4)
                        }
                        .frame(height: 250)
                    }
                case 1:
                    GroupBox("매출 추이") {
                        Chart(salesData, id: \.month) { item in
                            LineMark(
                                x: .value("월", item.month),
                                y: .value("매출", item.value)
                            )
                            .foregroundStyle(.green)
                            .symbol(.circle)

                            AreaMark(
                                x: .value("월", item.month),
                                y: .value("매출", item.value)
                            )
                            .foregroundStyle(.green.opacity(0.1))
                        }
                        .frame(height: 250)
                    }
                default:
                    GroupBox("카테고리 비율") {
                        Chart(categoryData, id: \.category) { item in
                            SectorMark(
                                angle: .value("비율", item.value),
                                innerRadius: .ratio(0.5),
                                angularInset: 2
                            )
                            .foregroundStyle(by: .value("카테고리", item.category))
                            .cornerRadius(4)
                        }
                        .frame(height: 250)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Swift Charts")
    }
}
