//
//  GitHubAPIServiceUseCaseTests.swift
//  GitHubTests
//
//  Created by Nyan Lin Tun on 16/5/25.
//

@testable import GitHub
import XCTest

final class GitHubAPIServiceUseCaseTests: XCTestCase {
    private var mockRepo: MockGitHubRepository!
    private var useCase: GitHubAPIServiceUseCase!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockGitHubRepository()
        useCase = GitHubAPIServiceUseCase(repository: mockRepo)
    }
    
    override func tearDown() {
        mockRepo = nil
        useCase = nil
        super.tearDown()
    }
    
    func testFetchUsers_CallsRepositoryAndReturnsData() async throws {
        let users = try await useCase.fetchUsers(since: nil)
        XCTAssertTrue(mockRepo.fetchUsersCalled)
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.id, 123)
        XCTAssertEqual(users.first?.login, "dummyUser")
    }
    
    func testFetchUserDetail_CallsRepositoryAndReturnsDetail() async throws {
        let detail = try await useCase.fetchUserDetail(username: "testUser")
        XCTAssertTrue(mockRepo.fetchDetailCalled)
        XCTAssertEqual(detail.login, "testUser")
        XCTAssertEqual(detail.name, "Dummy Name")
        XCTAssertEqual(detail.followers, 5)
        XCTAssertEqual(detail.following, 3)
    }
    
    func testFetchUserRepositories_CallsRepositoryAndFiltersForks() async throws {
        let repos = try await useCase.fetchUserRepositories(username: "testUser", page: 1, perPage: 10)
        XCTAssertTrue(mockRepo.fetchReposCalled)
        XCTAssertEqual(repos.count, 1)
        let repo = repos[0]
        XCTAssertEqual(repo.id, 456)
        XCTAssertEqual(repo.name, "dummy-repo")
        XCTAssertEqual(repo.language, "Swift")
        XCTAssertEqual(repo.starsCount, 42)
        XCTAssertEqual(repo.description, "A dummy repo")
        XCTAssertFalse(repo.fork)
        XCTAssertEqual(repo.htmlUrl, "https://github.com/dummyUser/dummy-repo")
    }
}
