import Combine
import Foundation

final class FavoritesStore: ObservableObject {
    @Published private(set) var favorites: [Repository] = []
    
    private let storage: StorageProtocol
    
    init(storage: StorageProtocol) {
        self.storage = storage
        reload()
    }
    
    func add(_ repository: Repository) {
        storage.saveRepository(repository)
        reload()
    }
    
    func remove(withId id: Int) {
        storage.removeRepository(withId: id)
        reload()
    }
    
    func loadAll() -> [Repository] {
        storage.loadFavoriteRepositories()
    }
    
    private func reload() {
        favorites = storage.loadFavoriteRepositories()
    }
}
