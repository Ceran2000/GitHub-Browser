
final class AppDependencies {
    private let apiClient: NetworkServiceProtocol
    
    init() {
        apiClient = GitHubAPIClient()
    }
    
    func makeRepositorySearchViewModel() -> RepositorySearchViewModel {
        RepositorySearchViewModel(apiClient: apiClient)
    }
}
