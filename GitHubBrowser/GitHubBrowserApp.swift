import SwiftUI

@main
struct GitHubBrowserApp: App {
    private let dependencies = AppDependencies()
    
    var body: some Scene {
        WindowGroup {
            RepositorySearchScreen(viewModel: dependencies.makeRepositorySearchViewModel())
        }
    }
}
