//
//  UserDetailViewModelTests.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

@testable import GitHub
import XCTest

@MainActor
final class UserDetailViewModelTests: XCTestCase {
    private var viewModel: UserDetailViewModel!
    private var mockUseCase: MockGitHubAPIServiceUseCase!

    override func setUp() {
        super.setUp()
        mockUseCase = MockGitHubAPIServiceUseCase()
        viewModel = UserDetailViewModel(githubApiServiceUseCase: mockUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }

    func testFetchUserDetail_successPublishesDetailAndClearsRepos() async {
        // Given
        let detail = GitHubUserDetail(
            login: "john",
            name: "John Doe",
            avatarUrl: "avatar.png",
            followers: 10,
            following: 5
        )
        mockUseCase.detailToReturn = detail
        // Pre-populate repos so we can verify they’re cleared
        viewModel.repos = [
            GitHubRepository(
              id: 1,
              name: "old",
              language: "",
              starsCount: 0,
              description: "",
              fork: false,
              htmlUrl: ""
            )
        ]

        // When
        await viewModel.fetchUserDetail(username: "john")

        // Then
        XCTAssertEqual(
            viewModel.userDetail,
            detail,
            "ViewModel should publish the fetched detail"
        )
        XCTAssertTrue(
            viewModel.repos.isEmpty,
            "Repos must be cleared when fetching a new user"
        )
        XCTAssertNil(
            viewModel.errorMessage,
            "errorMessage should be nil on success"
        )
    }
    
    func testFetchUserRepos_initialLoadFiltersOutForksAndStopsLoading() async {
        // Given
        let repo1 = GitHubRepository(
            id: 1,
            name: "repo1",
            language: "Swift",
            starsCount: 1,
            description: "d",
            fork: false,
            htmlUrl: ""
        )
        let repo2 = GitHubRepository(
            id: 2,
            name: "repo2",
            language: "Swift",
            starsCount: 2,
            description: "d2",
            fork: true,
            htmlUrl: ""
        )
        mockUseCase.reposToReturn = [repo1, repo2]

        // When
        await viewModel.fetchUserRepos(username: "john")

        // Then
        XCTAssertEqual(
            viewModel.repos,
            [repo1],
            "Should filter out forked repositories"
        )
        XCTAssertFalse(
            viewModel.isLoadingRepos,
            "isLoadingRepos should be false after load"
        )
        XCTAssertNil(
            viewModel.errorMessage,
            "errorMessage should be nil on success"
        )
    }

    func testFetchUserRepos_noMorePagesStopsFurtherRequests() async {
        // fewer than perPage to mark last
        mockUseCase.reposToReturn = (1..<5).map {
            GitHubRepository(
              id: $0,
              name: "r\($0)",
              language: "",
              starsCount: 0,
              description: "",
              fork: false,
              htmlUrl: ""
            )
        }
        await viewModel.fetchUserRepos(username: "john")

        // stub another item; should not append
        let extra = GitHubRepository(
            id: 99,
            name: "r99",
            language: "",
            starsCount: 0,
            description: "",
            fork: false,
            htmlUrl: ""
        )
        mockUseCase.reposToReturn = [extra]
        await viewModel.fetchUserRepos(username: "john")

        XCTAssertFalse(
            viewModel.repos.contains(
                where: {
                    $0.id == 99
                }
            ),
            "Should not fetch beyond last page"
        )
    }
}
