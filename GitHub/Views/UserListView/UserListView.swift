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
            Group {
                if viewModel.users.isEmpty && viewModel.isLoading {
                    ProgressView("Loading GitHub Users…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    userList                }
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
    
    private var userList: some View {
        List {
            ForEach(viewModel.users, id: \.id) { user in
                NavigationLink {
                    
                } label: {
                    UserRowView(user: user)
                        .onAppear {
                            if user == viewModel.users.last,
                               !viewModel.isLoading {
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
