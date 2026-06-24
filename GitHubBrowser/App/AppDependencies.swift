
final class AppDependencies {
    private let apiClient: NetworkServiceProtocol
    private let storage: StorageProtocol
    private let favoritesStore: FavoritesStore

    init() {
        apiClient = GitHubAPIClient()
        storage = UserDefaultsStorage()
        favoritesStore = FavoritesStore(storage: storage)
    }

    func makeRepositorySearchViewModel() -> RepositorySearchViewModel {
        RepositorySearchViewModel(apiClient: apiClient)
    }

    func makeRepositoryDetailViewModel(for repository: Repository) -> RepositoryDetailViewModel {
        RepositoryDetailViewModel(repository: repository, favoritesStore: favoritesStore)
    }

    func makeFavoritesViewModel() -> FavoritesViewModel {
        FavoritesViewModel(store: favoritesStore)
    }
}
