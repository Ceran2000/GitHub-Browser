import Foundation

final class UserDefaultsStorage: StorageProtocol {
    private let defaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    
    private let repositoryKey = "favorite_repositories"
    
    func saveRepository(_ repository: Repository) {
        var repositories = loadFavoriteRepositories()
        if repositories.contains(where: { $0.id == repository.id }) { return }
        
        repositories.append(repository)
        if let data = try? JSONEncoder().encode(repositories) {
            defaults.set(data, forKey: repositoryKey)
        }
    }
    
    func loadFavoriteRepositories() -> [Repository] {
        guard let data = defaults.data(forKey: repositoryKey) else { return [] }
        return (try? decoder.decode([Repository].self, from: data)) ?? []
    }
    
    func removeRepository(withId id: Int) {
        let repositories = loadFavoriteRepositories()
        let updatedRepositories = repositories.filter { $0.id != id }
        if let data = try? JSONEncoder().encode(updatedRepositories) {
            defaults.set(data, forKey: repositoryKey)
        }
    }
    
    func isRepositoryFavorite(id: Int) -> Bool {
        let repositories = loadFavoriteRepositories()
        return repositories.contains(where: { $0.id == id })
    }
    
    func saveDeveloper(_ developer: Developer) {
        //TODO
    }

    func loadFavoriteDevelopers() -> [Developer] {
        //TODO
        []
    }
    
    func removeDeveloper(withId id: Int) {
        //TODO
    }
    
    func isDeveloperFavorite(id: Int) -> Bool {
        //TODO
        false
    }
}
