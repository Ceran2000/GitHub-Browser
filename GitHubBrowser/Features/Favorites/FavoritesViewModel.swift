import Combine
import Foundation

final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Repository] = []
    
    private let storage: StorageProtocol
    
    init(storage: StorageProtocol) {
        self.storage = storage
    }
    
    func loadFavorites() {
        favorites = storage.loadFavoriteRepositories()
    }
    
    
}
