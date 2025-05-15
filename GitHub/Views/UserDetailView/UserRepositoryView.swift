//
//  UserRepositoryView.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 15/5/25.
//

import SwiftUI

struct UserRepositoryView: View {
    let repo: GitHubRepository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(repo.name ?? "")
                .font(.headline)
            HStack {
                if let lang = repo.language {
                    Text(lang)
                }
                Spacer()
                Text("★ \(repo.stargazersCount ?? 0)")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            if let desc = repo.description {
                Text(desc)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserRepositoryView(
        repo: .init(
            id: 1,
            name: "Test",
            language: "en",
            stargazersCount: 100,
            description: "Test description",
            fork: true,
            htmlUrl: ""
        )
    )
}
