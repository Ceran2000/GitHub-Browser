import Combine
import Foundation

final class RepositoryDetailViewModel: ObservableObject {
    let repository: Repository
    private let storage: StorageProtocol
    
    @Published var isFavorite: Bool = false
    
    func toggleFavorite() {
        if isFavorite {
            storage.removeRepository(withId: repository.id)
        } else {
            storage.saveRepository(repository)
        }
        isFavorite.toggle()
    }

    
    var formattedStars: String { repository.stargazersCount.formatted() }
    var formattedForks: String { repository.forksCount.formatted() }
    var formattedIssues: String { repository.openIssuesCount.formatted() }
                                    
    var formattedUpdatedAt: String {
        repository.updatedAt.formatted(date: .abbreviated, time: .omitted)
    }
                                    
    var repositoryUrl: URL? {
        URL(string: repository.htmlUrl)
    }
    
    init (repository: Repository, storage: StorageProtocol) {
        self.repository = repository
        self.storage = storage
        self.isFavorite = storage.isRepositoryFavorite(id: repository.id)
    }
}
