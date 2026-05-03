import SwiftUI

struct FavoritesScreen: View {
    @ObservedObject var viewModel: FavoritesViewModel
    let makeDetailViewModel:  (Repository) -> RepositoryDetailViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.favorites.isEmpty {
                    EmptyStateView(icon: "heart", message: "No favorites yet")
                } else {
                    List(viewModel.favorites) { repository in
                        NavigationLink(value: repository) {
                            RepositoryRowView(repository: repository)
                        }
                    }
                    .navigationDestination(for: Repository.self) { repo in
                        RepositoryDetailsScreen(viewModel: makeDetailViewModel(repo))
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear { viewModel.loadFavorites() }
        }
    }
}
