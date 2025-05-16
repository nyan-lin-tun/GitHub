//
//  GitHubUserDetailMapperTests.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

@testable import GitHub
import XCTest

final class GitHubUserDetailMapperTests: XCTestCase {
    private var mapper: GitHubUserDetailMapper!

    override func setUp() {
        super.setUp()
        mapper = GitHubUserDetailMapper()
    }

    override func tearDown() {
        mapper = nil
        super.tearDown()
    }

    func testMap_withAllFieldsPresent() {
        let response = GitHubUserDetailResponse(
            login: "testUser",
            name: "Test Name",
            avatarUrl: "https://example.com/avatar.png",
            followers: 10,
            following: 7
        )
        let model = mapper.map(input: response)
        XCTAssertEqual(model.login, "testUser")
        XCTAssertEqual(model.name, "Test Name")
        XCTAssertEqual(model.avatarUrl, "https://example.com/avatar.png")
        XCTAssertEqual(model.followers, 10)
        XCTAssertEqual(model.following, 7)
    }

    func testMap_withNilFields() {
        let response = GitHubUserDetailResponse(
            login: nil,
            name: nil,
            avatarUrl: nil,
            followers: nil,
            following: nil
        )
        let model = mapper.map(input: response)
        XCTAssertEqual(model.login, "")
        XCTAssertEqual(model.name, "")
        XCTAssertEqual(model.avatarUrl, "")
        XCTAssertEqual(model.followers, 0)
        XCTAssertEqual(model.following, 0)
    }
}
