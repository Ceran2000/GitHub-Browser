import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: repository.owner.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.secondary.opacity(0.2)
            }
            .frame(width: 44, height: 44)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(repository.fullName)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Label(repository.stargazersCount.formatted(.number.notation(.compactName)), systemImage: "star")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if let description = repository.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                if let language = repository.language {
                    Text(language)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
