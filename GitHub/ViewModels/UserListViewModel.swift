import Foundation

@MainActor
final class UserListViewModel: ObservableObject {
    @Published var users: [GitHubUser] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchUsers() async {
        isLoading = true
        do {
            let result = try await GitHubAPIService.shared.fetchUsers()
            self.users = result
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}