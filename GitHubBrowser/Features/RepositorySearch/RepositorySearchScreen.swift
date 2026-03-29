import SwiftUI
 
struct RepositorySearchScreen: View {
    @ObservedObject var viewModel: RepositorySearchViewModel
                                                                                                             
    var body: some View {
        List(viewModel.repositories) { repo in
            Text(repo.fullName)
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .task {
            await viewModel.search(query: "swift")
        }
    }
}
