import SwiftUI

struct ButtonShowcase: View {
    @State private var count = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                GroupBox("기본 스타일") {
                    VStack(spacing: 12) {
                        Button("Default") { count += 1 }
                            .buttonStyle(.automatic)

                        Button("Bordered") { count += 1 }
                            .buttonStyle(.bordered)

                        Button("Bordered Prominent") { count += 1 }
                            .buttonStyle(.borderedProminent)

                        Button("Borderless") { count += 1 }
                            .buttonStyle(.borderless)

                        Button(role: .destructive) { count += 1 } label: {
                            Text("Destructive")
                        }
                        .buttonStyle(.bordered)
                    }
                    .frame(maxWidth: .infinity)
                }

                GroupBox("커스텀 버튼") {
                    VStack(spacing: 12) {
                        Button {
                            count += 1
                        } label: {
                            Label("아이콘 버튼", systemImage: "star.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)

                        Button {
                            count += 1
                        } label: {
                            HStack {
                                Image(systemName: "heart.fill")
                                Text("풀 너비")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.pink.gradient, in: RoundedRectangle(cornerRadius: 12))
                            .foregroundStyle(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }

                Text("탭 횟수: \(count)")
                    .font(.headline)
                    .contentTransition(.numericText())
                    .animation(.default, value: count)
            }
            .padding()
        }
        .navigationTitle("Button 스타일")
    }
}
