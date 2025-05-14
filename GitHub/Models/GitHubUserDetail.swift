struct GitHubUserDetail: Codable {
    let login: String
    let name: String?
    let avatar_url: String
    let followers: Int
    let following: Int
}