import SwiftUI

struct SubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentTier: SubscriptionTier = .pro

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.vangoSun)

                    Text("Choose Your Plan")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Get the most out of VanGo for your food truck")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 10)

                // Tier Cards
                ForEach(SubscriptionTier.allCases) { tier in
                    TierCard(
                        tier: tier,
                        isCurrentTier: tier == currentTier,
                        onSelect: {
                            withAnimation { currentTier = tier }
                        }
                    )
                }
            }
            .padding(16)
        }
        .navigationTitle("Subscription")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") { dismiss() }
                    .foregroundStyle(.vangoSun)
            }
        }
    }
}

struct TierCard: View {
    let tier: SubscriptionTier
    let isCurrentTier: Bool
    let onSelect: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text(tier.displayName)
                            .font(.title3)
                            .fontWeight(.bold)

                        if tier == .pro {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundStyle(.yellow)
                        }
                    }

                    Text(tier.priceString)
                        .font(.headline)
                        .foregroundStyle(.vangoSun)
                }

                Spacer()

                if isCurrentTier {
                    Text("CURRENT")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.vangoOlive)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.vangoOlive.opacity(0.12), in: Capsule())
                }
            }

            ForEach(tier.features) { feature in
                HStack(spacing: 8) {
                    Image(systemName: feature.included ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.subheadline)
                        .foregroundStyle(feature.included ? .vangoOlive : Color.vangoSlate.opacity(0.5))

                    Text(feature.name)
                        .font(.subheadline)
                        .foregroundStyle(feature.included ? .primary : .secondary)
                }
            }

            if !isCurrentTier {
                Button(action: onSelect) {
                    Text(tier == .pro ? "Upgrade to Pro" : "Downgrade to Basic")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            tier == .pro ? Color.vangoSun : Color.vangoSlate,
                            in: RoundedRectangle(cornerRadius: 10)
                        )
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isCurrentTier ? Color.vangoSun : Color.vangoMist, lineWidth: isCurrentTier ? 2 : 1)
        )
    }
}

#Preview {
    NavigationStack {
        SubscriptionView()
    }
}
