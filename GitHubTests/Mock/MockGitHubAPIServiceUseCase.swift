//
//  MockGitHubAPIService.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

@testable import GitHub

final class MockGitHubAPIServiceUseCase: GitHubAPIServiceUseCaseDelegate {
    // MARK: – Stubbed outputs
    var usersToReturn: [GitHubUser] = []
    var detailToReturn: GitHubUserDetail?
    var reposToReturn: [GitHubRepository] = []

    // MARK: – Call trackers
    private(set) var fetchUsersCalled = false
    private(set) var fetchUserDetailCalled = false
    private(set) var fetchUserReposCalled = false
    private(set) var lastFetchUsername: String?
    private(set) var lastFetchPage: Int?
    private(set) var lastFetchPerPage: Int?

    func fetchUsers(since userID: Int?) async throws -> [GitHubUser] {
        fetchUsersCalled = true
        return usersToReturn
    }

    func fetchUserDetail(username: String) async throws -> GitHubUserDetail {
        fetchUserDetailCalled = true
        lastFetchUsername = username
        if let detail = detailToReturn {
            return detail
        }
        // default dummy
        return GitHubUserDetail(
            login: username,
            name: "",
            avatarUrl: "",
            followers: 0,
            following: 0
        )
    }

    func fetchUserRepositories(
        username: String,
        page: Int,
        perPage: Int
    ) async throws -> [GitHubRepository] {
        fetchUserReposCalled = true
        lastFetchUsername = username
        lastFetchPage = page
        lastFetchPerPage = perPage
        return reposToReturn
    }
}
