struct Developer: Identifiable, Hashable {
    let id: Int
    let login: String
    let avatarUrl: String
    let name: String?
    let bio: String?
    let followers: Int
    let following: Int
    let publicRepos: Int
    let htmlUrl: String
}
