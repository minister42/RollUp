import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
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
