import Foundation

@MainActor
final class AuthService: ObservableObject {
    private let apiClient: APIClient
    
    nonisolated init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    // MARK: - Authentication Methods
    
    func signIn(email: String, password: String) async throws -> AuthResponse {
        let endpoint = APIEndpoints.Auth.signIn(email: email, password: password)
        let response = try await apiClient.request(endpoint: endpoint, responseType: AuthResponse.self)
        
        // Save the access token
        apiClient.setAccessToken(response.accessToken)
        
        // TODO: Save refresh token securely in Keychain
        saveRefreshToken(response.refreshToken)
        
        return response
    }
    
    func signUp(email: String, password: String, displayName: String, role: UserRole) async throws -> AuthResponse {
        let endpoint = APIEndpoints.Auth.signUp(
            email: email,
            password: password,
            displayName: displayName,
            role: role
        )
        let response = try await apiClient.request(endpoint: endpoint, responseType: AuthResponse.self)
        
        // Save the access token
        apiClient.setAccessToken(response.accessToken)
        
        // TODO: Save refresh token securely in Keychain
        saveRefreshToken(response.refreshToken)
        
        return response
    }
    
    func signOut() async throws {
        let endpoint = APIEndpoints.Auth.signOut
        try await apiClient.request(endpoint: endpoint)
        
        // Clear tokens
        apiClient.setAccessToken(nil)
        clearRefreshToken()
    }
    
    func refreshToken() async throws -> AuthResponse {
        let endpoint = APIEndpoints.Auth.refreshToken
        let response = try await apiClient.request(endpoint: endpoint, responseType: AuthResponse.self)
        
        // Update tokens
        apiClient.setAccessToken(response.accessToken)
        saveRefreshToken(response.refreshToken)
        
        return response
    }
    
    // MARK: - Token Storage Helpers
    
    private func saveRefreshToken(_ token: String) {
        // TODO: Implement secure Keychain storage
        UserDefaults.standard.set(token, forKey: "refreshToken")
    }
    
    private func clearRefreshToken() {
        // TODO: Implement secure Keychain removal
        UserDefaults.standard.removeObject(forKey: "refreshToken")
    }
    
    func loadSavedSession() {
        apiClient.loadSavedToken()
    }
}
