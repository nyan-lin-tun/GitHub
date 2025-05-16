//
//  MockGitHubRepository.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

@testable import GitHub
import XCTest

final class MockGitHubRepository: GitHubAPIServiceDelegate {
    private(set) var fetchUsersCalled = false
    private(set) var fetchDetailCalled = false
    private(set) var fetchReposCalled = false
    
    func fetchUsers(since userID: Int?) async throws -> [GitHubUserResponse] {
        fetchUsersCalled = true
        return [
            .init(
                id: 123,
                login: "dummyUser",
                avatarUrl: "https://example.com/avatar.png"
            )
        ]
    }
    
    func fetchUserDetail(username: String) async throws -> GitHubUserDetailResponse {
        fetchDetailCalled = true
        return .init(
            login: username,
            name: "Dummy Name",
            avatarUrl: "https://example.com/avatar.png",
            followers: 5,
            following: 3
        )
    }
    
    func fetchUserRepositories(username: String, page: Int, perPage: Int) async throws -> [GitHubRepositoryResponse] {
        fetchReposCalled = true
        return [
            .init(
                id: 456,
                name: "dummy-repo",
                language: "Swift",
                stargazersCount: 42,
                description: "A dummy repo",
                fork: false,
                htmlUrl: "https://github.com/dummyUser/dummy-repo"
            )
        ]
    }
}
