import SwiftUI

struct AnimationShowcase: View {
    @State private var isAnimating = false
    @State private var rotation = 0.0
    @State private var scale = 1.0

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                GroupBox("Spring Animation") {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.blue.gradient)
                        .frame(width: isAnimating ? 200 : 100, height: 100)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isAnimating)
                }

                GroupBox("Rotation") {
                    Image(systemName: "gear")
                        .font(.system(size: 60))
                        .rotationEffect(.degrees(rotation))
                        .foregroundStyle(.orange)
                }

                GroupBox("Scale & Opacity") {
                    Circle()
                        .fill(.purple.gradient)
                        .frame(width: 80, height: 80)
                        .scaleEffect(scale)
                        .opacity(2 - scale)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: scale)
                }

                GroupBox("Phase Animator") {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.yellow)
                        .phaseAnimator([false, true]) { content, phase in
                            content
                                .scaleEffect(phase ? 1.5 : 1.0)
                                .rotationEffect(.degrees(phase ? 360 : 0))
                        } animation: { _ in
                            .easeInOut(duration: 1.5)
                        }
                }

                Button(isAnimating ? "리셋" : "애니메이션 시작") {
                    if isAnimating {
                        withAnimation { isAnimating = false }
                        rotation = 0
                        scale = 1.0
                    } else {
                        withAnimation { isAnimating = true }
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                            rotation = 360
                        }
                        scale = 1.5
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Animation")
    }
}
