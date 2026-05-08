import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            VStack(spacing: 12) {
                Image(systemName: "truck.box.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.vangoSun)

                Text("How will you use VanGo?")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("You can always switch later")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 16) {
                // Eater Card
                Button {
                    let user = User(
                        id: UUID().uuidString,
                        email: "user@example.com",
                        displayName: "Food Lover",
                        role: .eater,
                        avatarURL: nil,
                        createdAt: Date()
                    )
                    appState.signIn(user: user)
                } label: {
                    RoleCard(
                        icon: "fork.knife",
                        title: "I'm looking for food",
                        subtitle: "Find food trucks nearby, browse menus, read reviews, and get deals",
                        color: .vangoSun
                    )
                }

                // Truck Owner Card
                Button {
                    let user = User(
                        id: UUID().uuidString,
                        email: "owner@example.com",
                        displayName: "Truck Owner",
                        role: .truckOwner,
                        avatarURL: nil,
                        createdAt: Date()
                    )
                    appState.signIn(user: user)
                } label: {
                    RoleCard(
                        icon: "truck.box.fill",
                        title: "I own a food truck",
                        subtitle: "List your business, manage your menu, run promotions, and reach customers",
                        color: .vangoTerracotta
                    )
                }
            }
            .padding(.horizontal, 24)

            Spacer()
            Spacer()
        }
        .navigationTitle("Choose Role")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RoleCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundStyle(color)
                .frame(width: 56, height: 56)
                .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Color.vangoInk)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    NavigationStack {
        RoleSelectionView()
            .environmentObject(AppState())
    }
}
