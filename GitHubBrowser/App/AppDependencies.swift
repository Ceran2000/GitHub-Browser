
final class AppDependencies {
    private let apiClient: NetworkServiceProtocol
    private let storage: StorageProtocol
    
    init() {
        apiClient = GitHubAPIClient()
        storage = UserDefaultsStorage()
    }
    
    func makeRepositorySearchViewModel() -> RepositorySearchViewModel {
        RepositorySearchViewModel(apiClient: apiClient)
    }
    
    func makeRepositoryDetailViewModel(for repository: Repository) -> RepositoryDetailViewModel {
        RepositoryDetailViewModel(repository: repository, storage: storage)
    }
}
