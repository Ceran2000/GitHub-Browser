import Foundation

enum Endpoint {
    case searchRepositories(query: String, page: Int)
    case repository(owner: String, name: String)
    case searchDevelopers(query: String, page: Int)
    case developer(login: String)
    case developerRepositories(login: String)
}

extension Endpoint {
    nonisolated var url: URL? {
        let base = "https://api.github.com"
        switch self {
        case .searchRepositories(let query, let page):
            var components = URLComponents(string: "\(base)/search/repositories")
            components?.queryItems = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "20")
            ]
            return components?.url
        case .repository(let owner, let name):
            return URL(string: "\(base)/repos/\(owner)/\(name)")
        case .searchDevelopers(let query, let page):
            var components = URLComponents(string: "\(base)/search/users")
            components?.queryItems = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "20")
            ]
            return components?.url
        case .developer(let login):
            return URL(string: "\(base)/users/\(login)")
        case .developerRepositories(let login):
            return URL(string: "\(base)/users/\(login)/repos")
        }
    }
}
