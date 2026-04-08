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

                if let error = viewModel.error {
                    ErrorView(message: error.localizedDescription)
                } else {
                    List(viewModel.repositories) { repo in
                        Text(repo.fullName)
                    }
                    .overlay {
                        if viewModel.isLoading {
                            ProgressView()
                        }
                    }
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
