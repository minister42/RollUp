import SwiftUI

struct StatusBadge: View {
    let isOpen: Bool

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(isOpen ? Color.vangoOlive : Color.red)
                .frame(width: 8, height: 8)
            Text(isOpen ? "Open" : "Closed")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(isOpen ? Color.vangoOlive : Color.red)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(isOpen ? Color.vangoOlive.opacity(0.12) : Color.red.opacity(0.12))
        )
    }
}

struct PromotedBadge: View {
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "megaphone.fill")
                .font(.caption2)
            Text("PROMOTED")
                .font(.caption2)
                .fontWeight(.bold)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(
            Capsule()
                .fill(Color.vangoSun)
        )
    }
}

struct TierBadge: View {
    let tier: SubscriptionTier

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: tier == .pro ? "crown.fill" : "checkmark.seal.fill")
                .font(.caption2)
            Text(tier.displayName.uppercased())
                .font(.caption2)
                .fontWeight(.bold)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(
            Capsule()
                .fill(tier == .pro ? Color.vangoSun : Color.vangoSlate)
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        StatusBadge(isOpen: true)
        StatusBadge(isOpen: false)
        PromotedBadge()
        TierBadge(tier: .basic)
        TierBadge(tier: .pro)
    }
}
