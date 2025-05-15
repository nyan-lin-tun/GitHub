//
//  UserItemView.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

import SwiftUI

struct UserRowView: View {
    let user: GitHubUser
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            Text(user.login)
        }
    }
}

#Preview {
    UserRowView(
        user: .init(
            id: 1,
            login: "Login Name",
            avatarUrl: "https://avatars.githubusercontent.com/u/12773508?v=4"
        )
    )
}
