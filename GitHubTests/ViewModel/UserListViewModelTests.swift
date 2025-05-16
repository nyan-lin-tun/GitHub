//
//  abstraction.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

@testable import GitHub
import XCTest
import Combine

final class UserListViewModelTests: XCTestCase {
    private var viewModel: UserListViewModel!
    private var mockService: MockGitHubAPIService!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockGitHubAPIService()
        viewModel = UserListViewModel(service: mockService)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchUsers_success_updatesUsersAndClearsLoading() {
        // Given
        let expected = [ GitHubUser(id: 1, login: "alice", avatar_url: "url") ]
        mockService.usersToReturn = expected

        // Track loading states
        let loadingExpectation = expectation(description: "isLoading toggles")
        loadingExpectation.expectedFulfillmentCount = 2
        var loadingStates = [Bool]()
        viewModel.$isLoading
            .sink { loading in
                loadingStates.append(loading)
                loadingExpectation.fulfill()
            }
            .store(in: &cancellables)

        // Track users
        let usersExpectation = expectation(description: "users published")
        viewModel.$users
            .dropFirst()
            .sink { users in
                XCTAssertEqual(users, expected)
                usersExpectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        Task {
            await viewModel.fetchUsers()
        }

        // Then
        wait(for: [loadingExpectation, usersExpectation], timeout: 1)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(loadingStates, [true, false])
    }

    func testFetchUsers_failure_setsErrorMessageAndClearsLoading() {
        // Given
        let testError = URLError(.notConnectedToInternet)
        mockService.errorToThrow = testError

        let loadingExpectation = expectation(description: "isLoading toggles")
        loadingExpectation.expectedFulfillmentCount = 2
        viewModel.$isLoading
            .dropFirst()
            .sink { _ in loadingExpectation.fulfill() }
            .store(in: &cancellables)

        let errorExpectation = expectation(description: "errorMessage published")
        viewModel.$errorMessage
            .dropFirst()
            .sink { msg in
                XCTAssertEqual(msg, testError.localizedDescription)
                errorExpectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        Task {
            await viewModel.fetchUsers()
        }

        // Then
        wait(for: [loadingExpectation, errorExpectation], timeout: 1)
        XCTAssertTrue(viewModel.users.isEmpty)
    }
}
