//
//  GitHubUserDetailMapper.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Foundation

struct GitHubUserDetailMapper: ModelMapper {
    typealias Input = GitHubUserDetailResponse
    typealias Output = GitHubUserDetail
    
    func map(input: GitHubUserDetailResponse) -> GitHubUserDetail {
        .init(
            login: input.login ?? "",
              name: input.name ?? "",
              avatarUrl: input.avatarUrl ?? "",
              followers: input.followers ?? 0,
              following: input.following ?? 0
        )
    }
}
