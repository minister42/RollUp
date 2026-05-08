import SwiftUI

struct CouponsSectionView: View {
    let coupons: [Coupon]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Coupons", icon: "ticket")

            ForEach(coupons.filter(\.isActive)) { coupon in
                CouponBannerView(coupon: coupon)
            }
        }
    }
}

struct CouponBannerView: View {
    let coupon: Coupon
    @State private var redeemed = false

    var body: some View {
        HStack(spacing: 12) {
            // Discount badge
            VStack(spacing: 2) {
                Text(coupon.discountDisplay)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.vangoSun)
            }
            .frame(width: 80)

            // Info
            VStack(alignment: .leading, spacing: 3) {
                Text(coupon.description)
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack(spacing: 8) {
                    Text("Code: \(coupon.code)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.vangoSun)

                    Text("Exp: \(coupon.expiresAt.formatted(.dateTime.month().day()))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Button {
                withAnimation { redeemed = true }
            } label: {
                Text(redeemed ? "Saved!" : "Redeem")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(redeemed ? .white : .vangoSun)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        redeemed ? Color.vangoOlive : Color.vangoSun.opacity(0.12),
                        in: Capsule()
                    )
            }
            .disabled(redeemed)
        }
        .padding(12)
        .background(Color.vangoMist, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    CouponsSectionView(coupons: SampleData.coupons(forTruck: "truck-001"))
        .padding()
}
