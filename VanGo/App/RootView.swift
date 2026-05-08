import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState

    /// Splash is a one-time UI gate, not application state. Local @State
    /// resets per-view-instance, which matches the desired UX (shown once
    /// per cold start; not re-shown on background-resume since SwiftUI keeps
    /// the View alive across foreground transitions).
    @State private var splashComplete = false

    var body: some View {
        ZStack {
            mainContent
                .opacity(splashComplete ? 1 : 0)

            if !splashComplete {
                SplashView { splashComplete = true }
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: splashComplete)
    }

    @ViewBuilder
    private var mainContent: some View {
        Group {
            if !appState.isAuthenticated {
                AuthGateView()
            } else if let role = appState.selectedRole {
                switch role {
                case .eater:
                    EaterTabView()
                case .truckOwner:
                    TruckOwnerTabView()
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: appState.isAuthenticated)
        .animation(.easeInOut(duration: 0.3), value: appState.selectedRole)
    }
}

#Preview("Root - Not Authenticated") {
    RootView()
        .environmentObject(AppState())
}

#Preview("Root - Eater") {
    RootView()
        .environmentObject(AppState.previewEater)
}

#Preview("Root - Owner") {
    RootView()
        .environmentObject(AppState.previewOwner)
}
