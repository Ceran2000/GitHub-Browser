import Combine
import Foundation

final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Repository] = []
    
    private let store: FavoritesStore
    
    init(store: FavoritesStore) {
        self.store = store
        store.$favorites.assign(to: &$favorites)
    }
    
    
}
