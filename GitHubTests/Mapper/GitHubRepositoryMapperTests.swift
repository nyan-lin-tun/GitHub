//
//  GitHubRepositoryMapperTests.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

@testable import GitHub
import XCTest

final class GitHubRepositoryMapperTests: XCTestCase {
    private var mapper: GitHubRepositoryMapper!

    override func setUp() {
        super.setUp()
        mapper = GitHubRepositoryMapper()
    }

    override func tearDown() {
        mapper = nil
        super.tearDown()
    }

    func testMap_withAllFieldsPresent() {
        // Given
        let response = GitHubRepositoryResponse(
            id: 1,
            name: "TestRepo",
            language: "Swift",
            stargazersCount: 100,
            description: "A test repository",
            fork: true,
            htmlUrl: "https://github.com/test/TestRepo"
        )

        // When
        let model = mapper.map(input: response)

        // Then
        XCTAssertEqual(model.id, 1)
        XCTAssertEqual(model.name, "TestRepo")
        XCTAssertEqual(model.language, "Swift")
        XCTAssertEqual(model.starsCount, 100)
        XCTAssertEqual(model.description, "A test repository")
        XCTAssertTrue(model.fork)
        XCTAssertEqual(model.htmlUrl, "https://github.com/test/TestRepo")
    }

    func testMap_withNilOptionalFields() {
        // Given
        let response = GitHubRepositoryResponse(
            id: 2,
            name: nil,
            language: nil,
            stargazersCount: nil,
            description: nil,
            fork: nil,
            htmlUrl: nil
        )

        // When
        let model = mapper.map(input: response)

        // Then
        XCTAssertEqual(model.id, 2)
        XCTAssertEqual(model.name, "")
        XCTAssertEqual(model.language, "")
        XCTAssertEqual(model.starsCount, 0)
        XCTAssertEqual(model.description, "")
        XCTAssertFalse(model.fork)
        XCTAssertEqual(model.htmlUrl, "")
    }
}
