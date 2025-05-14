import Foundation

final class GitHubAPIService {
    static let shared = GitHubAPIService()

    private let baseURL = "https://api.github.com"
    private let session: URLSession

    // You can load this from Secrets.plist or use env vars for production
    private let token = "your_personal_access_token"

    private init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Authorization": "token \(token)",
            "Accept": "application/vnd.github+json"
        ]
        session = URLSession(configuration: config)
    }

    func fetchUsers() async throws -> [GitHubUser] {
        let url = URL(string: "\(baseURL)/users")!
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([GitHubUser].self, from: data)
    }

    func fetchUserDetail(username: String) async throws -> GitHubUserDetail {
        let url = URL(string: "\(baseURL)/users/\(username)")!
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(GitHubUserDetail.self, from: data)
    }

    func fetchUserRepositories(username: String) async throws -> [GitHubRepository] {
        let url = URL(string: "\(baseURL)/users/\(username)/repos")!
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([GitHubRepository].self, from: data)
    }
}