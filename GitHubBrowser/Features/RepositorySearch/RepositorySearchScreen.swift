import SwiftUI

struct RepositorySearchScreen: View {
    @ObservedObject var viewModel: RepositorySearchViewModel

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Szukaj repozytoriów...", text: $viewModel.searchQuery)
                    .onChange(of: viewModel.searchQuery) { _, query in viewModel.queryChanged(to: query) }
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
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
                        RepositoryDetailsScreen(viewModel: RepositoryDetailViewModel(repository: repo))
                    }
                case .error(let error):
                    ErrorView(message: error.localizedDescription)
                }
            }
            .navigationTitle("GitHubBrowser")
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
