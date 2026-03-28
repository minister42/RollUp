import SwiftUI

struct EaterCouponsView: View {
    private let coupons = SampleData.coupons.filter(\.isActive)

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                if coupons.isEmpty {
                    EmptyStateView(
                        icon: "ticket",
                        title: "No deals available",
                        message: "Check back later for deals from food trucks near you"
                    )
                    .frame(height: 400)
                } else {
                    ForEach(coupons) { coupon in
                        CouponCardView(coupon: coupon)
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("Deals")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct CouponCardView: View {
    let coupon: Coupon
    @State private var redeemed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                // Discount badge
                Text(coupon.discountDisplay)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.rollUpOrange)

                Spacer()

                if redeemed {
                    Label("Saved", systemImage: "checkmark.circle.fill")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.rollUpGreen)
                }
            }

            Text(coupon.truckName)
                .font(.headline)

            Text(coupon.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            // Dashed line separator
            HStack(spacing: 4) {
                ForEach(0..<30, id: \.self) { _ in
                    Circle()
                        .fill(Color.rollUpGray.opacity(0.3))
                        .frame(width: 4, height: 4)
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Code")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text(coupon.code)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.rollUpOrange)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("Expires")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text(coupon.expiresAt.formatted(.dateTime.month().day().year()))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button {
                    withAnimation { redeemed = true }
                } label: {
                    Text(redeemed ? "Redeemed" : "Redeem")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            redeemed ? Color.rollUpGreen : Color.rollUpOrange,
                            in: RoundedRectangle(cornerRadius: 10)
                        )
                }
                .disabled(redeemed)
            }
        }
        .padding(16)
        .cardStyle()
    }
}

#Preview {
    NavigationStack {
        EaterCouponsView()
    }
}
