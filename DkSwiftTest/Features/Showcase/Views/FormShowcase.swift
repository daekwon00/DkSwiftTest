import SwiftUI

struct FormShowcase: View {
    @State private var name = ""
    @State private var isOn = true
    @State private var volume = 0.5
    @State private var selectedColor = "Blue"
    @State private var date = Date.now
    @State private var stepperValue = 3

    private let colors = ["Blue", "Red", "Green", "Purple"]

    var body: some View {
        Form {
            Section("TextField") {
                TextField("이름을 입력하세요", text: $name)
                TextField("비활성화됨", text: .constant("읽기 전용"))
                    .disabled(true)
            }

            Section("Toggle & Slider") {
                Toggle("알림 설정", isOn: $isOn)
                VStack(alignment: .leading) {
                    Text("볼륨: \(Int(volume * 100))%")
                    Slider(value: $volume)
                }
            }

            Section("Picker & Stepper") {
                Picker("색상", selection: $selectedColor) {
                    ForEach(colors, id: \.self) { Text($0) }
                }
                Stepper("수량: \(stepperValue)", value: $stepperValue, in: 1...10)
            }

            Section("DatePicker") {
                DatePicker("날짜", selection: $date, displayedComponents: .date)
                DatePicker("시간", selection: $date, displayedComponents: .hourAndMinute)
            }

            Section("LabeledContent") {
                LabeledContent("읽기 전용", value: "값")
                LabeledContent("상태") {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
        }
        .navigationTitle("Form 컴포넌트")
    }
}
