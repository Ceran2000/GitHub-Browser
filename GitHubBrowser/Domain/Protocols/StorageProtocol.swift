protocol StorageProtocol {
    func saveRepository(_ repository: Repository)
    func saveDeveloper(_ developer: Developer)
    func loadFavoriteRepositories() -> [Repository]
    func loadFavoriteDevelopers() -> [Developer]
    func removeRepository(withId id: Int)
    func removeDeveloper(withId id: Int)
    func isRepositoryFavorite(id: Int) -> Bool
    func isDeveloperFavorite(id: Int) -> Bool
}
