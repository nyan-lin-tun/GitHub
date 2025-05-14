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
                List(viewModel.users) { user in
                    HStack {
                        AsyncImage(url: URL(string: user.avatar_url)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                        Text(user.login)
                    }
                }
                .navigationTitle("GitHub Users")
                .task {
                    await viewModel.fetchUsers()
                }
            }
        }
}

#Preview {
    UserListView()
}
