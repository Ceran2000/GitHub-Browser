struct OwnerDTO: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String

    func toDomain() -> Owner {
        Owner(id: id, login: login, avatarUrl: avatarUrl)
    }
}
