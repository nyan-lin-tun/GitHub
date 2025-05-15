//
//  GitHubAPIService.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

import Foundation

protocol GitHubAPIServiceDelegate: AnyObject {
    func fetchUsers(since userID: Int?) async throws -> [GitHubUser]
    func fetchUserDetail(username: String) async throws -> GitHubUserDetail
    func fetchUserRepositories(
        username: String,
        page: Int,
        perPage: Int
    ) async throws -> [GitHubRepository]
}

final class GitHubAPIService {
    static let shared = GitHubAPIService()

    private let baseURL = "https://api.github.com"
    var session: URLSession

    private let token = AppConfig.appToken

    init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Authorization": "token \(token)",
            "Accept": "application/vnd.github+json"
        ]
        session = URLSession(configuration: config)
    }
    
    func fetchUsers(since userID: Int? = nil) async throws -> [GitHubUser] {
        var urlString = "\(baseURL)/users"
        if let id = userID {
            urlString += "?since=\(id)"
        }
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([GitHubUser].self, from: data)
    }
    
    func fetchUserDetail(username: String) async throws -> GitHubUserDetail {
        guard let url = URL(string: "\(baseURL)/users/\(username)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(GitHubUserDetail.self, from: data)
    }

    func fetchUserRepositories(
        username: String,
        page: Int = 1,
        perPage: Int = 30
    ) async throws -> [GitHubRepository] {
        var components = URLComponents(string: "\(baseURL)/users/\(username)/repos")
        components?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([GitHubRepository].self, from: data)
    }
}
