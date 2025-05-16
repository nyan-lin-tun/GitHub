//
//  UserDetailView.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 15/5/25.
//

import SwiftUI

struct UserDetailView: View {
    let username: String
    @StateObject private var viewModel = UserDetailViewModel()
    
    var body: some View {
        ScrollView {
            // MARK: – User Info Header
            VStack(alignment: .leading) {
                if let detail = viewModel.userDetail {
                    Section {
                        headerView(detail: detail)
                            .padding(.vertical)
                    }
                }
            }
            .padding()
            Section(header: Text("Repositories")) {
                if viewModel.repos.isEmpty && viewModel.isLoadingRepos {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(viewModel.repos, id: \.id) { repo in
                        VStack {
                            userRepositoryView(repo: repo)
                            Divider()
                        }
                        .onAppear {
                            // MARK: - pagination
                            if repo == viewModel.repos.last {
                                Task {
                                    await viewModel.fetchUserRepos(username: username)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(username)
        .onAppear {
            // only fetch once
            Task {
                await viewModel.fetchUserDetail(username: username)
                await viewModel.fetchUserRepos(username: username)
            }
        }
    }
    
    private func userRepositoryView(repo: GitHubRepository) -> some View {
        Group {
            if let url = URL(string: repo.htmlUrl) {
                NavigationLink(destination: webView(url, repoName: repo.name)) {
                    UserRepositoryView(repo: repo)
                }
            } else {
                EmptyView()
            }
        }
    }
    
    private func webView(_ url: URL, repoName: String) -> some View {
        WebView(url: url)
            .navigationTitle(repoName)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private func headerView(detail: GitHubUserDetail) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: detail.avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            Text(detail.login)
                .font(.title.weight(.bold))
            Text(detail.name)
                .font(.headline)
            HStack {
                Text("Followers: \(detail.followers)")
                Spacer()
                Text("Following: \(detail.following)")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}

#Preview {
    UserDetailView(username: "mojombo")
}
