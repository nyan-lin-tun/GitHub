//
//  ContentView.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users, id: \.id) { user in
                    HStack {
                        UserRowView(user: user)
                            .onAppear {
                                if user == viewModel.users.last {
                                    Task {
                                        // MARK: - do pagination
                                        await viewModel.fetchUsers()
                                    }
                                }
                            }
                    }
                }
                if viewModel.isLoading {
                    loadingView
                }
            }
            .navigationTitle("GitHub Users")
            .task {
                // Initial load
                if viewModel.users.isEmpty {
                    await viewModel.fetchUsers()
                }
            }
        }
    }
    
    private var loadingView: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

#Preview {
    UserListView()
}
