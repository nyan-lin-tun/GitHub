//
//  GitHubRepository.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//


struct GitHubRepository: Codable, Identifiable {
    let id: Int
    let name: String
    let language: String?
    let stargazers_count: Int
    let description: String?
    let fork: Bool
    let html_url: String
}
