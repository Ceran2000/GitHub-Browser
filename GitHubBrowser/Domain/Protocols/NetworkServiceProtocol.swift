protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, endpoint: Endpoint) async throws -> T
}
