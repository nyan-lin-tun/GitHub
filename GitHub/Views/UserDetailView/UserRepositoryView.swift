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
            Text(repo.name)
                .font(.headline)
            HStack {
                Text(repo.language)
                Spacer()
                Text("★ \(repo.starsCount)")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            Text(repo.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
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
            starsCount: 100,
            description: "Test description",
            fork: true,
            htmlUrl: ""
        )
    )
}
