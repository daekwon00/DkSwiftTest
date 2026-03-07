import Foundation

enum AppError: LocalizedError {
    case network(URLError)
    case decode(DecodingError)
    case server(statusCode: Int)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .network(let error):
            return "네트워크 오류: \(error.localizedDescription)"
        case .decode:
            return "데이터 처리 오류가 발생했습니다."
        case .server(let code):
            return "서버 오류 (\(code))"
        case .unknown(let error):
            return error.localizedDescription
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .network:
            return "인터넷 연결을 확인하고 다시 시도해주세요."
        case .decode:
            return "앱을 업데이트해주세요."
        case .server:
            return "잠시 후 다시 시도해주세요."
        case .unknown:
            return "다시 시도해주세요."
        }
    }
}
