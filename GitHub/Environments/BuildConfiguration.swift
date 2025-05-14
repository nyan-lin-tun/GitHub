//
//  Plist.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

import Foundation

enum Plist {
    case appToken
    
    var value: String {
        switch self {
        case .appToken:
            return "App Token"
        }
    }
}

enum AppConfig {
    static var appToken: String {
        return configuration(.appToken)
    }
    
    private static func configuration(_ key: Plist) -> String {
        if let infoDictionary = Bundle.main.infoDictionary {
            switch key {
            case .appToken:
                return infoDictionary[Plist.appToken.value] as? String ?? "App Token"
            }
        } else {
            fatalError("Unable to load plist file")
        }
    }
}
