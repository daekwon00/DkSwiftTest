import SwiftUI

struct ErrorStateView: View {
    let title: String
    let message: String
    let retryAction: (() -> Void)?

    init(title: String = "오류 발생", message: String, retryAction: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.retryAction = retryAction
    }

    init(error: AppError, retryAction: (() -> Void)? = nil) {
        self.title = "오류 발생"
        self.message = error.errorDescription ?? "알 수 없는 오류"
        self.retryAction = retryAction
    }

    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: "exclamationmark.triangle")
        } description: {
            Text(message)
        } actions: {
            if let retryAction {
                Button("다시 시도") { retryAction() }
                    .buttonStyle(.bordered)
            }
        }
    }
}
