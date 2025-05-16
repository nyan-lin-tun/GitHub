//
//  GitHubApiRoutes.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Foundation

class GitHubApiRoutes {
    enum Endpoint {
        case users
        case details(String)
        case repositories(String)
        
        var stringValue: String {
            switch self {
            case .users:
                return "\(baseUrl)/users"
                
            case .details(let username):
                return "\(baseUrl)/users/\(username)"
                
            case .repositories(let username):
                return "\(baseUrl)/users/\(username)/repos"
            }
        }
    }
    
    private static let baseUrl = AppConfig.baseUrl
}
