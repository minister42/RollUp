import SwiftUI

struct OwnerDashboardView: View {
    private let truck = SampleData.trucks[0] // Preview: Taco Libre
    @State private var isOpen = true
    @State private var showLocationPicker = false
    @State private var showEditProfile = false
    @State private var showSubscription = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Open/Closed Toggle
                VStack(spacing: 12) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Open for Business")
                                .font(.headline)
                            if truck.tier == .pro {
                                HStack(spacing: 4) {
                                    Image(systemName: "antenna.radiowaves.left.and.right")
                                        .font(.caption)
                                    Text(isOpen ? "Live tracking active" : "Tracking paused")
                                        .font(.caption)
                                }
                                .foregroundStyle(isOpen ? .rollUpGreen : .secondary)
                            }
                        }

                        Spacer()

                        Toggle("", isOn: $isOpen)
                            .tint(.rollUpGreen)
                            .labelsHidden()
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isOpen ? Color.rollUpGreen.opacity(0.08) : Color.rollUpLightGray)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isOpen ? Color.rollUpGreen.opacity(0.3) : Color.clear, lineWidth: 1)
                )

                // Stats
                HStack(spacing: 12) {
                    StatCard(value: "42", label: "Views Today", icon: "eye.fill", color: .blue)
                    StatCard(value: String(format: "%.1f", truck.averageRating), label: "Rating", icon: "star.fill", color: .yellow)
                    StatCard(value: "3", label: "Coupons", icon: "ticket.fill", color: .rollUpOrange)
                }

                // Subscription Status
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        TierBadge(tier: truck.tier)
                        Spacer()
                        Button("Manage") { showSubscription = true }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.rollUpOrange)
                    }

                    Text("Your \(truck.tier.displayName) subscription is active")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(16)
                .cardStyle()

                // Quick Actions
                VStack(alignment: .leading, spacing: 12) {
                    Text("QUICK ACTIONS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)

                    Button { showLocationPicker = true } label: {
                        QuickActionRow(icon: "mappin.and.ellipse", title: "Update Location", subtitle: "Set your current position", color: .green)
                    }

                    Button { showEditProfile = true } label: {
                        QuickActionRow(icon: "square.and.pencil", title: "Edit Profile", subtitle: "Update truck info & social links", color: .blue)
                    }

                    NavigationLink {
                        AdPackagesView()
                    } label: {
                        QuickActionRow(icon: "megaphone.fill", title: "Promote Truck", subtitle: "Boost your visibility", color: .rollUpOrange)
                    }
                }

                // Recent Reviews
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        SectionHeader(title: "Recent Reviews", icon: "star.bubble")
                        Spacer()
                        Text("See All")
                            .font(.subheadline)
                            .foregroundStyle(.rollUpOrange)
                    }

                    ForEach(SampleData.reviews(forTruck: truck.id).prefix(2)) { review in
                        ReviewRow(review: review)
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle(truck.name)
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showLocationPicker) {
            LocationPinView()
        }
        .sheet(isPresented: $showEditProfile) {
            NavigationStack {
                EditTruckProfileView()
            }
        }
        .sheet(isPresented: $showSubscription) {
            NavigationStack {
                SubscriptionView()
            }
        }
    }
}

struct StatCard: View {
    let value: String
    let label: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .cardStyle()
    }
}

struct QuickActionRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundStyle(color)
                .frame(width: 36, height: 36)
                .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .background(Color.rollUpLightGray, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        OwnerDashboardView()
    }
    .environmentObject(AppState.previewOwner)
}
