import SwiftUI

struct EaterProfileView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        List {
            // Profile header
            Section {
                HStack(spacing: 14) {
                    Circle()
                        .fill(Color.vangoSun.opacity(0.2))
                        .frame(width: 64, height: 64)
                        .overlay {
                            Text(String(appState.currentUser?.displayName.prefix(1) ?? "?"))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.vangoSun)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(appState.currentUser?.displayName ?? "Food Lover")
                            .font(.headline)
                        Text(appState.currentUser?.email ?? "user@example.com")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }

            // Favorites
            Section("Favorites") {
                ProfileRow(icon: "heart.fill", title: "Saved Trucks", color: .red) {}
                ProfileRow(icon: "clock.fill", title: "Recent Orders", color: .blue) {}
                ProfileRow(icon: "ticket.fill", title: "My Coupons", color: .vangoSun) {}
            }

            // Settings
            Section("Settings") {
                ProfileRow(icon: "bell.fill", title: "Notifications", color: .purple) {}
                ProfileRow(icon: "location.fill", title: "Location Settings", color: .green) {}
                ProfileRow(icon: "questionmark.circle.fill", title: "Help & Support", color: .cyan) {}
                ProfileRow(icon: "doc.text.fill", title: "Terms of Service", color: .gray) {}
                ProfileRow(icon: "lock.shield.fill", title: "Privacy Policy", color: .gray) {}
            }

            // Sign out
            Section {
                Button {
                    appState.signOut()
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

            // App version
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text("VanGo v1.0.0")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("Made with ❤️ for food truck lovers")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundStyle(color)
                    .frame(width: 28, height: 28)
                    .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 7))

                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        EaterProfileView()
    }
    .environmentObject(AppState.previewEater)
}
