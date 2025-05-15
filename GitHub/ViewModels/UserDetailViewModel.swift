//
//  UserDetailViewModel.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 15/5/25.
//

import Foundation

protocol UserDetailViewModelDelegate: AnyObject {
    func fetchUserDetail(username: String) async
    func fetchUserRepos(username: String) async
}

@MainActor
final class UserDetailViewModel: UserDetailViewModelDelegate, ObservableObject {
    @Published var userDetail: GitHubUserDetail?
    @Published var repos: [GitHubRepository] = []
    @Published var isLoadingRepos = false
    @Published var errorMessage: String?

    private var currentPage = 1
    private let perPage = 30
    private var hasMoreRepos = true

    func fetchUserDetail(username: String) async {
        // Reset pagination when loading a new user
        currentPage = 1
        hasMoreRepos = true
        repos = []
        do {
            userDetail = try await GitHubAPIService.shared.fetchUserDetail(username: username)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func fetchUserRepos(username: String) async {
        // Only fetch if not already loading and if more pages remain
        guard !isLoadingRepos, hasMoreRepos else {
            return
        }
        isLoadingRepos = true
        defer {
            isLoadingRepos = false
        }

        do {
            let batch = try await GitHubAPIService.shared
                .fetchUserRepositories(username: username, page: currentPage, perPage: perPage)
            let filtered = batch.filter {
                !($0.fork ?? false)
            }
            if currentPage == 1 {
                repos = filtered
            } else {
                repos.append(contentsOf: filtered)
            }
            if batch.count == perPage {
                currentPage += 1
            } else {
                hasMoreRepos = false
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
