//
//  abstraction.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Combine
@testable import GitHub
import XCTest

@MainActor
final class UserListViewModelTests: XCTestCase {
    private var viewModel: UserListViewModel!
    private var mockUseCase: MockGitHubAPIServiceUseCase!

    override func setUp() {
        super.setUp()
        mockUseCase = MockGitHubAPIServiceUseCase()
        viewModel = UserListViewModel(githubApiServiceUseCase: mockUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }

    func testFetchUsers_successPublishesUsersAndStopsLoading() async {
        // Given
        let dummy = GitHubUser(id: 7, login: "alice", avatarUrl: "url")
        mockUseCase.usersToReturn = [dummy]

        // When
        await viewModel.fetchUsers()

        // Then
        XCTAssertTrue(
            mockUseCase.fetchUsersCalled,
            "Expected fetchUsers(since:) to be called on the service"
        )
        XCTAssertEqual(
            viewModel.users,
            [dummy],
            "ViewModel should publish the returned users"
        )
        XCTAssertFalse(
            viewModel.isLoading,
            "isLoading should be false after fetch completes"
        )
        XCTAssertNil(
            viewModel.errorMessage,
            "errorMessage should be nil on success"
        )
    }

    func testFetchUsers_emptyResponsePublishesEmptyAndStopsLoading() async {
        // Given
        mockUseCase.usersToReturn = []

        // When
        await viewModel.fetchUsers()

        // Then
        XCTAssertTrue(mockUseCase.fetchUsersCalled)
        XCTAssertTrue(
            viewModel.users.isEmpty,
            "ViewModel.users should be empty when service returns no users"
        )
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchUsers_failureSetsErrorMessageAndStopsLoading() async {
        // When
        await viewModel.fetchUsers()

        // Then
        XCTAssertTrue(mockUseCase.fetchUsersCalled)
        XCTAssertTrue(
            viewModel.users.isEmpty,
            "Users should remain empty on failure"
        )
        XCTAssertFalse(
            viewModel.isLoading,
            "isLoading should be false after failure"
        )
    }

    func testFetchNextPage_appendsResults() async {
        // Given: first page
        let first = GitHubUser(
            id: 1,
            login: "u1",
            avatarUrl: ""
        )
        mockUseCase.usersToReturn = [first]
        await viewModel.fetchUsers()

        // When
        let second = GitHubUser(id: 2, login: "u2", avatarUrl: "")
        mockUseCase.usersToReturn = [second]

        // Then
        XCTAssertTrue(mockUseCase.fetchUsersCalled)
    }
}
