import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    @Published var selectedRole: UserRole?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Services
    private let authService: AuthService
    private let userService: UserService
    
    init(
        authService: AuthService = AuthService(),
        userService: UserService = UserService()
    ) {
        self.authService = authService
        self.userService = userService
    }
    
    // MARK: - Authentication Methods
    
    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await authService.signIn(email: email, password: password)
            currentUser = response.user
            selectedRole = response.user.role
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = false
        }
        
        isLoading = false
    }
    
    func signUp(email: String, password: String, displayName: String, role: UserRole) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await authService.signUp(
                email: email,
                password: password,
                displayName: displayName,
                role: role
            )
            currentUser = response.user
            selectedRole = response.user.role
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
            isAuthenticated = false
        }
        
        isLoading = false
    }
    
    func signOut() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await authService.signOut()
            currentUser = nil
            selectedRole = nil
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func loadSavedSession() async {
        authService.loadSavedSession()
        
        do {
            let user = try await userService.getCurrentUser()
            currentUser = user
            selectedRole = user.role
            isAuthenticated = true
        } catch {
            // Session is invalid, clear it
            currentUser = nil
            selectedRole = nil
            isAuthenticated = false
        }
    }
    
    // MARK: - Legacy Methods (for backward compatibility with existing code)
    
    func signIn(user: User) {
        currentUser = user
        selectedRole = user.role
        isAuthenticated = true
    }

    // MARK: - Preview helpers
    static let previewEater: AppState = {
        let state = AppState()
        state.signIn(user: User.preview)
        return state
    }()

    static let previewOwner: AppState = {
        let state = AppState()
        state.signIn(user: User.previewOwner)
        return state
    }()
}
