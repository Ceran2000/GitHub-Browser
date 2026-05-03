import SwiftUI

@main
struct GitHubBrowserApp: App {
    private let dependencies = AppDependencies()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                RepositorySearchScreen(
                    viewModel: dependencies.makeRepositorySearchViewModel(),
                    makeDetailViewModel: dependencies.makeRepositoryDetailViewModel(for:)
                )
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                
                FavoritesScreen(
                    viewModel: dependencies.makeFavoritesViewModel(),
                    makeDetailViewModel: dependencies.makeRepositoryDetailViewModel(for:)
                )
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            }
        }
    }
}
