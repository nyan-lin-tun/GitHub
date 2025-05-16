//
//  GitHubUser.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Foundation

struct GitHubUser: Identifiable, Equatable {
    let id: Int
    let login: String
    let avatarUrl: String
    
    init(
        id: Int = -1,
        login: String = "",
        avatarUrl: String = ""
    ) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
    }
}
