//
//  GitHubUserMapperTests.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

@testable import GitHub
import XCTest

final class GitHubUserMapperTests: XCTestCase {
    private var mapper: GitHubUserMapper!

    override func setUp() {
        super.setUp()
        mapper = GitHubUserMapper()
    }

    override func tearDown() {
        mapper = nil
        super.tearDown()
    }

    func testMap_withAllFieldsPresent() {
        // Given
        let response = GitHubUserResponse(
            id: 42,
            login: "octocat",
            avatarUrl: "https://example.com/avatar.png"
        )

        // When
        let model = mapper.map(input: response)

        // Then
        XCTAssertEqual(model.id, 42)
        XCTAssertEqual(model.login, "octocat")
        XCTAssertEqual(model.avatarUrl, "https://example.com/avatar.png")
    }

    func testMap_withNilOptionalFields() {
        // Given
        let response = GitHubUserResponse(
            id: 7,
            login: nil,
            avatarUrl: nil
        )

        // When
        let model = mapper.map(input: response)

        // Then
        XCTAssertEqual(model.id, 7)
        XCTAssertEqual(model.login, "")          // default for nil
        XCTAssertEqual(model.avatarUrl, "")      // default for nil
    }
}
