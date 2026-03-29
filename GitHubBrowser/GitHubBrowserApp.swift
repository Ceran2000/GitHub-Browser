import SwiftUI

@main
struct GitHubBrowserApp: App {
    var body: some Scene {
        WindowGroup {
            RepositorySearchScreen(viewModel: RepositorySearchViewModel(apiClient: GitHubAPIClient()))
        }
    }
}
