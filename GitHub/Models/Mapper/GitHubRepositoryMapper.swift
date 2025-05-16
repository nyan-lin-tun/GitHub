//
//  GitHubRepositoryMapper.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Foundation

struct GitHubRepositoryMapper: ModelMapper {
    typealias Input = GitHubRepositoryResponse
    typealias Output = GitHubRepository
    
    func map(input: GitHubRepositoryResponse) -> GitHubRepository {
        return .init(
            id: input.id,
            name: input.name ?? "",
            language: input.language ?? "",
            starsCount: input.stargazersCount ?? 0,
            description: input.description ?? "",
            fork: input.description ?? false,
            htmlUrl: input.htmlUrl ?? ""
        )
    }
}
