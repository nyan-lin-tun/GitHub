struct GitHubUserDetail: Codable {
    enum CodingKeys: String, CodingKey {
        case login
        case name
        case avatarUrl = "avatar_url"
        case followers
        case following
    }
    
    let login: String
    let name: String?
    let avatarUrl: String
    let followers: Int
    let following: Int
}