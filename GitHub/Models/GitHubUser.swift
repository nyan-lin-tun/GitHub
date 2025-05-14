//
//  GitHubUser.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

import Foundation

struct GitHubUser: Codable, Equatable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
    
    let id: Int
    let login: String
    let avatarUrl: String
}
