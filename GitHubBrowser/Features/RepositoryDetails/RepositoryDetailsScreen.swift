import SwiftUI

struct RepositoryDetailsScreen: View {
    @ObservedObject var viewModel: RepositoryDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                OwnerSection(owner: viewModel.repository.owner)
                
                if let description = viewModel.repository.description {
                    Text(description)
                        .foregroundStyle(.secondary)
                }
                
                StatsSection(viewModel: viewModel)
                
                if let language = viewModel.repository.language {
                    Label(language, systemImage: "chevron.left.forwardslash.chevron.right")
                        .font(.subheadline)
                }
                
                Label(viewModel.formattedUpdatedAt, systemImage: "clock")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if let url = viewModel.repositoryUrl {
                    Link("Otwórz na GitHub", destination: url)
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.repository.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.toggleFavorite() }) {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                }
            }
        }
    }
}

private struct OwnerSection: View {
    let owner: Owner
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: owner.avatarUrl)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.secondary.opacity(0.3)
            }
            .frame(width: 48, height: 48)
            .clipShape(Circle())
            
            Text(owner.login)
                .font(.headline)
        }
    }
}

private struct StatsSection: View {
    let viewModel: RepositoryDetailViewModel
                                                                                                                                    
    var body: some View {
        HStack(spacing: 0) {
            StatView(icon: "star", label: "Stars", value: viewModel.formattedStars)
            Divider()
            StatView(icon: "tuningfork", label: "Forks", value: viewModel.formattedForks)
            Divider()
            StatView(icon: "exclamationmark.circle", label: "Issues", value: viewModel.formattedIssues)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

private struct StatView: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}
