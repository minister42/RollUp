import Foundation

@MainActor
final class UserService: ObservableObject {
    private let apiClient: APIClient
    
    nonisolated init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    // MARK: - User Methods
    
    func getCurrentUser() async throws -> User {
        let endpoint = APIEndpoints.User.getCurrentUser
        return try await apiClient.request(endpoint: endpoint, responseType: User.self)
    }
    
    func getUser(userId: String) async throws -> User {
        let endpoint = APIEndpoints.User.getUser(userId: userId)
        return try await apiClient.request(endpoint: endpoint, responseType: User.self)
    }
    
    func updateProfile(
        userId: String,
        displayName: String? = nil,
        avatarURL: URL? = nil,
        email: String? = nil
    ) async throws -> User {
        let updates = UserUpdateRequest(
            displayName: displayName,
            avatarURL: avatarURL,
            email: email
        )
        let endpoint = APIEndpoints.User.updateProfile(userId: userId, updates: updates)
        return try await apiClient.request(endpoint: endpoint, responseType: User.self)
    }
    
    func deleteAccount(userId: String) async throws {
        let endpoint = APIEndpoints.User.deleteAccount(userId: userId)
        try await apiClient.request(endpoint: endpoint)
    }
}
