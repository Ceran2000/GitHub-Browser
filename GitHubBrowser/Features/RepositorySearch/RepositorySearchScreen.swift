import SwiftUI

struct RepositorySearchScreen: View {
    @ObservedObject var viewModel: RepositorySearchViewModel
    let makeDetailViewModel: (Repository) -> RepositoryDetailViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .initial:
                    EmptyStateView(icon: "magnifyingglass", message: "Wpisz nazwę repozytorium, żeby wyszukać")
                case .loading:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .empty:
                    EmptyStateView(icon: "tray", message: "Brak wyników dla \"\(viewModel.searchQuery)\"")
                case .results(let repositories):
                    List(repositories) { repo in
                        NavigationLink(value: repo) {
                            RepositoryRowView(repository: repo)
                        }
                    }
                    .navigationDestination(for: Repository.self) { repo in
                        RepositoryDetailsScreen(viewModel: makeDetailViewModel(repo))
                    }
                case .error(let error):
                    ErrorView(message: error.localizedDescription)
                }
            }
            .navigationTitle("GitHubBrowser")
            .searchable(
                text: $viewModel.searchQuery,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Szukaj repozytoriów..."
            )
            .onChange(of: viewModel.searchQuery) { _, query in viewModel.queryChanged(to: query) }
        }
    }
}

private struct ErrorView: View {
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
