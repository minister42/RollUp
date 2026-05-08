import SwiftUI

struct OwnerProfileView: View {
    @EnvironmentObject var appState: AppState
    private let truck = SampleData.trucks[0]

    var body: some View {
        List {
            // Profile header
            Section {
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(Color.vangoSun.opacity(0.2))
                            .frame(width: 64, height: 64)

                        Text(truck.cuisineType.icon)
                            .font(.title)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(truck.name)
                            .font(.headline)
                        HStack(spacing: 4) {
                            TierBadge(tier: truck.tier)
                            StatusBadge(isOpen: truck.isOpen)
                        }
                    }
                }
                .padding(.vertical, 4)
            }

            // Business
            Section("Business") {
                ProfileRow(icon: "creditcard.fill", title: "Subscription", color: .vangoSun) {}
                ProfileRow(icon: "chart.bar.fill", title: "Analytics", color: .blue) {}
                ProfileRow(icon: "dollarsign.circle.fill", title: "Revenue & Payments", color: .green) {}
            }

            // Settings
            Section("Settings") {
                ProfileRow(icon: "bell.fill", title: "Notifications", color: .purple) {}
                ProfileRow(icon: "location.fill", title: "Location Settings", color: .green) {}
                ProfileRow(icon: "clock.fill", title: "Business Hours", color: .orange) {}
                ProfileRow(icon: "questionmark.circle.fill", title: "Help & Support", color: .cyan) {}
                ProfileRow(icon: "doc.text.fill", title: "Terms of Service", color: .gray) {}
                NavigationLink {
                    AboutView()
                } label: {
                    ProfileRowLabel(icon: "info.circle.fill", title: "About VanGo", color: .vangoCobalt, showChevron: false)
                }
            }

            // Sign out
            Section {
                Button {
                    Task {
                        await appState.signOut()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Sign Out")
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                        Spacer()
                    }
                }
            }

            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text("VanGo for Business v1.0.0")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        OwnerProfileView()
    }
    .environmentObject(AppState.previewOwner)
}
