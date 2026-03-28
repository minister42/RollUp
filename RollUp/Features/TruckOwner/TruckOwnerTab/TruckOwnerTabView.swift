import SwiftUI

struct TruckOwnerTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Dashboard", systemImage: "chart.bar.fill", value: 0) {
                NavigationStack {
                    OwnerDashboardView()
                }
            }

            Tab("Menu", systemImage: "menucard.fill", value: 1) {
                NavigationStack {
                    MenuManagementView()
                }
            }

            Tab("Coupons", systemImage: "ticket.fill", value: 2) {
                NavigationStack {
                    CouponManagementView()
                }
            }

            Tab("Advertise", systemImage: "megaphone.fill", value: 3) {
                NavigationStack {
                    AdPackagesView()
                }
            }

            Tab("Profile", systemImage: "person.fill", value: 4) {
                NavigationStack {
                    OwnerProfileView()
                }
            }
        }
        .tint(.rollUpOrange)
    }
}

#Preview {
    TruckOwnerTabView()
        .environmentObject(AppState.previewOwner)
}
