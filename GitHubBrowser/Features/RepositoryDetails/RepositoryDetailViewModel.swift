import Combine
import Foundation

final class RepositoryDetailViewModel: ObservableObject {
    let repository: Repository
    
    init (repository: Repository) {
        self.repository = repository
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
}
