//
//  GitHubUser.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//


struct GitHubUser: Codable, Identifiable {
    let id: Int
    let login: String
    let avatar_url: String
}