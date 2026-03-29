import Foundation

struct RepositoryDTO: Decodable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let owner: OwnerDTO
    let stargazersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let language: String?
    let htmlUrl: String
    let updatedAt: Date

    func toDomain() -> Repository {
        Repository(
            id: id,
            name: name,
            fullName: fullName,
            description: description,
            owner: owner.toDomain(),
            stargazersCount: stargazersCount,
            forksCount: forksCount,
            openIssuesCount: openIssuesCount,
            language: language,
            htmlUrl: htmlUrl,
            updatedAt: updatedAt
        )
    }
}
