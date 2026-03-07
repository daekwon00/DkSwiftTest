import SwiftUI

struct AlertSheetShowcase: View {
    @State private var showAlert = false
    @State private var showConfirm = false
    @State private var showSheet = false
    @State private var showFullScreen = false
    @State private var lastAction = "없음"

    var body: some View {
        List {
            Section("Alert") {
                Button("기본 Alert") { showAlert = true }
                Button("확인/취소 Alert") { showConfirm = true }
            }

            Section("Sheet") {
                Button("Sheet 표시") { showSheet = true }
                Button("Full Screen Cover") { showFullScreen = true }
            }

            Section("마지막 액션") {
                Text(lastAction)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Alert & Sheet")
        .alert("알림", isPresented: $showAlert) {
            Button("확인") { lastAction = "Alert 확인" }
        } message: {
            Text("기본 알림 메시지입니다.")
        }
        .alert("확인", isPresented: $showConfirm) {
            Button("삭제", role: .destructive) { lastAction = "삭제 선택" }
            Button("취소", role: .cancel) { lastAction = "취소 선택" }
        } message: {
            Text("정말 삭제하시겠습니까?")
        }
        .sheet(isPresented: $showSheet) {
            SheetContent(lastAction: $lastAction)
                .presentationDetents([.medium, .large])
        }
        .fullScreenCover(isPresented: $showFullScreen) {
            NavigationStack {
                VStack(spacing: 20) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .font(.largeTitle)
                    Text("Full Screen Cover")
                        .font(.title)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("닫기") {
                            showFullScreen = false
                            lastAction = "Full Screen 닫기"
                        }
                    }
                }
            }
        }
    }
}

private struct SheetContent: View {
    @Binding var lastAction: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "rectangle.bottomhalf.inset.filled")
                    .font(.largeTitle)
                Text("Sheet Content")
                    .font(.title)
                Text("드래그하여 크기를 조절할 수 있습니다.")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Sheet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") {
                        lastAction = "Sheet 닫기"
                        dismiss()
                    }
                }
            }
        }
    }
}
