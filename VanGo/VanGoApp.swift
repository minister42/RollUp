import SwiftUI

@main
struct VanGoApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var container = DependencyContainer.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(container)
        }
    }
}
