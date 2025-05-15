//
//  UserListViewModel.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

import Foundation

protocol UserListViewModelDelegate: AnyObject {
    func fetchUsers() async
}

@MainActor
final class UserListViewModel: UserListViewModelDelegate, ObservableObject {
    @Published var users: [GitHubUser] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchUsers() async {
        guard !isLoading else {
            return
        }
        isLoading = true
        do {
            let lastID = users.last?.id
            let newUsers = try await GitHubAPIService.shared.fetchUsers(since: lastID)
            self.users += newUsers
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
