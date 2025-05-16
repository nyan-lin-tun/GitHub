//
//  GitHubUserResponse.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

import Foundation

struct GitHubUserResponse: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
    
    let id: Int
    let login: String?
    let avatarUrl: String?
}
