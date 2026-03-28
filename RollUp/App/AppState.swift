import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated: Bool = false
    @Published var selectedRole: UserRole?

    func signIn(user: User) {
        currentUser = user
        selectedRole = user.role
        isAuthenticated = true
    }

    func signOut() {
        currentUser = nil
        selectedRole = nil
        isAuthenticated = false
    }

    // Preview helpers
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
