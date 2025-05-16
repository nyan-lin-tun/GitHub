//
//  GitHubUserMapper.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Foundation

struct GitHubUserMapper: ModelMapper {
    typealias Input = GitHubUserResponse
    typealias Output = GitHubUser
    
    func map(input: GitHubUserResponse) -> GitHubUser {
        .init(
            id: input.id,
            login: input.login ?? "",
            avatarUrl: input.avatarUrl ?? ""
        )
    }
}
