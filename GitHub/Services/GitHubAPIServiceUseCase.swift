//
//  GitHubAPIServiceUseCase.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Foundation

protocol GitHubAPIServiceUseCaseDelegate: AnyObject {
    func fetchUsers(since userID: Int?) async throws -> [GitHubUser]
    func fetchUserDetail(username: String) async throws -> GitHubUserDetail
    func fetchUserRepositories(
        username: String,
        page: Int,
        perPage: Int
    ) async throws -> [GitHubRepository]
}

final class GitHubAPIServiceUseCase: GitHubAPIServiceUseCaseDelegate {
    private var repository: GitHubAPIServiceDelegate
    
    init(repository: GitHubAPIServiceDelegate = GitHubAPIService()) {
        self.repository = repository
    }
    
    func fetchUsers(since userID: Int?) async throws -> [GitHubUser] {
        let response = try await repository.fetchUsers(since: userID)
        return response.map {
            GitHubUserMapper().map(input: $0)
        }
    }
    
    func fetchUserDetail(username: String) async throws -> GitHubUserDetail {
        let response = try await repository.fetchUserDetail(username: username)
        return GitHubUserDetailMapper().map(input: response)
    }
    
    func fetchUserRepositories(username: String, page: Int, perPage: Int) async throws -> [GitHubRepository] {
        let response = try await repository.fetchUserRepositories(username: username, page: page, perPage: perPage)
        return response.map {
            GitHubRepositoryMapper().map(input: $0)
        }
    }
}
