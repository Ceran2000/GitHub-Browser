import Combine
import Foundation

@MainActor
final class RepositorySearchViewModel: ObservableObject {
    private let apiClient: NetworkServiceProtocol
    
    @Published private(set) var repositories: [Repository] = []
    
    @Published var searchQuery: String = ""
    private var searchTask: Task<Void, Never>?
    
    func queryChanged(to query: String) {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { return }
            await search(query: query)
        }
    }
    
    
    @Published private(set) var isLoading = false
    @Published private(set) var error: NetworkError?
    
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
