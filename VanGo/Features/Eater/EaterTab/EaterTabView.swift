import SwiftUI

struct EaterTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ExploreView()
            }
            .tabItem {
                Label("Explore", systemImage: "magnifyingglass")
            }
            .tag(0)

            NavigationStack {
                MapExploreView()
            }
            .tabItem {
                Label("Map", systemImage: "map.fill")
            }
            .tag(1)

            NavigationStack {
                EaterCouponsView()
            }
            .tabItem {
                Label("Deals", systemImage: "ticket.fill")
            }
            .tag(2)

            NavigationStack {
                EaterProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
            .tag(3)
        }
        .tint(.vangoSun)
    }
}

#Preview {
    EaterTabView()
        .environmentObject(AppState.previewEater)
}
