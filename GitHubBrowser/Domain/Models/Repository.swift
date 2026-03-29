import Foundation

struct Repository: Identifiable, Hashable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let owner: Owner
    let stargazersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let language: String?
    let htmlUrl: String
    let updatedAt: Date
}
