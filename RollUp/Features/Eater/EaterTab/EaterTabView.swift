import SwiftUI

struct EaterTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Explore", systemImage: "magnifyingglass", value: 0) {
                NavigationStack {
                    ExploreView()
                }
            }

            Tab("Map", systemImage: "map.fill", value: 1) {
                NavigationStack {
                    MapExploreView()
                }
            }

            Tab("Deals", systemImage: "ticket.fill", value: 2) {
                NavigationStack {
                    EaterCouponsView()
                }
            }

            Tab("Profile", systemImage: "person.fill", value: 3) {
                NavigationStack {
                    EaterProfileView()
                }
            }
        }
        .tint(.rollUpOrange)
    }
}

#Preview {
    EaterTabView()
        .environmentObject(AppState.previewEater)
}
