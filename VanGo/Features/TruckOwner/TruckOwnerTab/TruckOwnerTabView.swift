import SwiftUI

struct TruckOwnerTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                OwnerDashboardView()
            }
            .tabItem {
                Label("Dashboard", systemImage: "chart.bar.fill")
            }
            .tag(0)

            NavigationStack {
                MenuManagementView()
            }
            .tabItem {
                Label("Menu", systemImage: "menucard.fill")
            }
            .tag(1)

            NavigationStack {
                CouponManagementView()
            }
            .tabItem {
                Label("Coupons", systemImage: "ticket.fill")
            }
            .tag(2)

            NavigationStack {
                AdPackagesView()
            }
            .tabItem {
                Label("Advertise", systemImage: "megaphone.fill")
            }
            .tag(3)

            NavigationStack {
                OwnerProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
            .tag(4)
        }
        .tint(.vangoSun)
    }
}

#Preview {
    TruckOwnerTabView()
        .environmentObject(AppState.previewOwner)
}
