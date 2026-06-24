import SwiftUI

struct FavoritesScreen: View {
    @ObservedObject var viewModel: FavoritesViewModel
    let makeDetailViewModel:  (Repository) -> RepositoryDetailViewModel
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
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
            .onChange(of: viewModel.favorites) {
                path = NavigationPath()
            }
        }
    }
}
