import Combine
import Foundation

@MainActor
final class RepositorySearchViewModel: ObservableObject {
    private let apiClient: NetworkServiceProtocol
    
    @Published var state: RepositoryListState = .initial
    
    @Published var searchQuery: String = ""
    private var searchTask: Task<Void, Never>?
    
    func queryChanged(to query: String) {
        searchTask?.cancel()
        guard !query.isEmpty else {
            state = .initial
            return
        }
        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { return }
            await search(query: query)
        }
    }
    
    init(apiClient: NetworkServiceProtocol) {
        self.apiClient = apiClient
    }
    
    func search(query: String) async {
        guard !query.isEmpty else {
            state = .initial
            return
        }
        state = .loading
        
        do {
            let response = try await apiClient.fetch(
                RepositorySearchResponseDTO.self,
                endpoint: .searchRepositories(query: query, page: 1)
            )
            let results = response.items.map { $0.toDomain() }
            if !results.isEmpty {
                state = .results(results)
            } else {
                state = .empty
            }
        } catch let networkError as NetworkError {
            state = .error(networkError)
        } catch {
            state = .error(.requestFailed(statusCode: 0))
        }
    }
}
