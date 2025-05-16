//
//  GitHubRepository.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Foundation

struct GitHubRepository: Equatable, Identifiable {
    let id: Int
    let name: String
    let language: String
    let starsCount: Int
    let description: String
    let fork: Bool
    let htmlUrl: String
    
    init(
        id: Int = -1,
        name: String = "",
        language: String = "",
        starsCount: Int = 0,
        description: String = "",
        fork: Bool = false,
        htmlUrl: String = ""
    ) {
        self.id = id
        self.name = name
        self.language = language
        self.starsCount = starsCount
        self.description = description
        self.fork = fork
        self.htmlUrl = htmlUrl
    }
}
