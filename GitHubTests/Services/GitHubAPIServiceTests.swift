//
//  ContentView.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

@testable import GitHub
import XCTest

final class GitHubAPIServiceTests: XCTestCase {
    var service: GitHubAPIService!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: config)
        service = GitHubAPIService()
        service.session = mockSession
    }

    func testFetchUsersReturnsExpectedUsers() async throws {
        let expectedJSON = """
        [
            {
                "login": "octocat",
                "id": 1,
                "avatar_url": "url"
            }
        ]
        """
        guard let url = URL(string: "https://api.github.com/users") else {
            XCTFail("Invalid URL")
            return
        }
        MockURLProtocol.mockData = expectedJSON.data(using: .utf8)
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let users = try await service.fetchUsers()
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.login, "octocat")
        XCTAssertEqual(users.first?.id, 1)
    }

    func testFetchUserDetailReturnsExpectedDetail() async throws {
        let expectedJSON = """
        {
            "login": "octocat",
            "name": "The Octocat",
            "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4",
            "followers": 100,
            "following": 50
        }
        """
        guard let url = URL(string: "https://api.github.com/users/octocat") else {
            XCTFail("Invalid URL")
            return
        }
        MockURLProtocol.mockData = expectedJSON.data(using: .utf8)
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let detail = try await service.fetchUserDetail(username: "octocat")
        XCTAssertEqual(detail.login, "octocat")
        XCTAssertEqual(detail.name, "The Octocat")
        XCTAssertEqual(detail.avatar_url, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(detail.followers, 100)
        XCTAssertEqual(detail.following, 50)
    }

    func testFetchUserRepositoriesReturnsExpectedRepos() async throws {
        let expectedJSON = """
        [
            {
                "id": 1296269,
                "name": "Hello-World",
                "full_name": "octocat/Hello-World",
                "stargazers_count": 1
            }
        ]
        """
        guard let url = URL(string: "https://api.github.com/users/octocat/repos") else {
            XCTFail("Invalid URL")
            return
        }
        MockURLProtocol.mockData = expectedJSON.data(using: .utf8)
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let repos = try await service.fetchUserRepositories(username: "octocat")
        XCTAssertEqual(repos.count, 1)
        XCTAssertEqual(repos.first?.name, "Hello-World")
    }
}
