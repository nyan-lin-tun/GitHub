//
//  GitHubRepository.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

import Foundation

struct GitHubRepository: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case language
        case stargazersCount = "stargazers_count"
        case description
        case fork
        case htmlUrl = "html_url"
    }
    
    let id: Int
    let name: String?
    let language: String?
    let stargazersCount: Int?
    let description: String?
    let fork: Bool?
    let htmlUrl: String?
}
