struct RepositorySearchResponseDTO: Decodable {
    let totalCount: Int
    let items: [RepositoryDTO]
}
