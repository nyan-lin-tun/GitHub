//
//  GitHubAPIService.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

import Foundation

protocol GitHubAPIServiceDelegate: AnyObject {
    func fetchUsers(since userID: Int?) async throws -> [GitHubUserResponse]
    func fetchUserDetail(username: String) async throws -> GitHubUserDetailResponse
    func fetchUserRepositories(
        username: String,
        page: Int,
        perPage: Int
    ) async throws -> [GitHubRepositoryResponse]
}

final class GitHubAPIService: GitHubAPIServiceDelegate {
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
    
    func fetchUsers(since userID: Int? = nil) async throws -> [GitHubUserResponse] {
        var urlString = GitHubApiRoutes.Endpoint.users.stringValue
        if let id = userID {
            urlString += "?since=\(id)"
        }
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([GitHubUserResponse].self, from: data)
    }
    
    func fetchUserDetail(username: String) async throws -> GitHubUserDetailResponse {
        let urlString = GitHubApiRoutes.Endpoint.details(username).stringValue
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(GitHubUserDetailResponse.self, from: data)
    }

    func fetchUserRepositories(
        username: String,
        page: Int = 1,
        perPage: Int = 30
    ) async throws -> [GitHubRepositoryResponse] {
        let urlString = GitHubApiRoutes.Endpoint.repositories(username).stringValue
        var components = URLComponents(string: urlString)
        components?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([GitHubRepositoryResponse].self, from: data)
    }
}
