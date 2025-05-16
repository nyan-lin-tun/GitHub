//
//  GitHubUserDetail.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Foundation

struct GitHubUserDetail: Equatable {
    let login: String
    let name: String
    let avatarUrl: String
    let followers: Int
    let following: Int
    
    init(
        login: String,
        name: String,
        avatarUrl: String,
        followers: Int,
        following: Int
    ) {
        self.login = login
        self.name = name
        self.avatarUrl = avatarUrl
        self.followers = followers
        self.following = following
    }
}
