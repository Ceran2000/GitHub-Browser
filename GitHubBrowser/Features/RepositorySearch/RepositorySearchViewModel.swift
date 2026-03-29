import Foundation
import Combine

@MainActor
final class RepositorySearchViewModel: ObservableObject {
    @Published private(set) var repositories: [Repository] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: NetworkError?
    
    private let apiClient: NetworkServiceProtocol
    
    init(apiClient: NetworkServiceProtocol) {
        self.apiClient = apiClient
    }
    
    func search(query: String) async {
        guard !query.isEmpty else { return }
        isLoading = true
        error = nil
        
        do {
            let response = try await apiClient.fetch(
                RepositorySearchResponseDTO.self,
                endpoint: .searchRepositories(query: query, page: 1)
            )
            repositories = response.items.map { $0.toDomain() }
        } catch let networkError as NetworkError {
            self.error = networkError
        } catch {
            self.error = .requestFailed(statusCode: 0)
        }
        
        isLoading = false
    }
}
