enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingFailed
    case rateLimitExceeded
    case noInternetConnection
}
