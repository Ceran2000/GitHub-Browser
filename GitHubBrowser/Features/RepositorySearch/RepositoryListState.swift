enum RepositoryListState {
    case initial
    case loading
    case empty
    case results([Repository])
    case error(NetworkError)
}
