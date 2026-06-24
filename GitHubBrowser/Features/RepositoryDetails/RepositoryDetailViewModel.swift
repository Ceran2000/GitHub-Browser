import Combine
import Foundation

final class RepositoryDetailViewModel: ObservableObject {
    let repository: Repository
    private let favoritesStore: FavoritesStore
    
    @Published var isFavorite: Bool = false
    
    func toggleFavorite() {
        if isFavorite {
            favoritesStore.remove(withId: repository.id)
        } else {
            favoritesStore.add(repository)
        }
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
    
    init (repository: Repository, favoritesStore: FavoritesStore) {
        self.repository = repository
        self.favoritesStore = favoritesStore
        
        favoritesStore.$favorites
            .map { $0.contains {
                $0.id == repository.id
            }
        }
            .assign(to: &$isFavorite)
    }
}
