import SwiftUI

struct CouponManagementView: View {
    private let coupons = SampleData.coupons(forTruck: "truck-001")
    @State private var showCreateCoupon = false

    var body: some View {
        List {
            Section {
                // Revenue share info
                HStack(spacing: 12) {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(.blue)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Revenue Share")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text("\(Int(AppConstants.defaultRevenueSharePercent))% of coupon value goes to RollUp when redeemed")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }

            Section("Active Coupons") {
                ForEach(coupons.filter(\.isActive)) { coupon in
                    NavigationLink {
                        CouponEditorView(coupon: coupon)
                    } label: {
                        CouponManagementRow(coupon: coupon)
                    }
                }
            }

            Section("Stats") {
                HStack {
                    Text("Total Redemptions")
                    Spacer()
                    Text("\(coupons.map(\.currentRedemptions).reduce(0, +))")
                        .fontWeight(.semibold)
                        .foregroundStyle(.rollUpOrange)
                }

                HStack {
                    Text("Active Coupons")
                    Spacer()
                    Text("\(coupons.filter(\.isActive).count)")
                        .fontWeight(.semibold)
                        .foregroundStyle(.rollUpOrange)
                }
            }
        }
        .navigationTitle("Coupons")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showCreateCoupon = true
                } label: {
                    Image(systemName: "plus")
                        .fontWeight(.semibold)
                        .foregroundStyle(.rollUpOrange)
                }
            }
        }
        .sheet(isPresented: $showCreateCoupon) {
            NavigationStack {
                CouponEditorView(coupon: nil)
            }
        }
    }
}

struct CouponManagementRow: View {
    let coupon: Coupon

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(coupon.discountDisplay)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.rollUpOrange)

                Spacer()

                Text("Code: \(coupon.code)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }

            Text(coupon.description)
                .font(.subheadline)

            HStack {
                Text("\(coupon.currentRedemptions) redeemed")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                if let max = coupon.maxRedemptions {
                    Text("of \(max)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("Expires \(coupon.expiresAt.formatted(.dateTime.month().day()))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // Progress bar
            if let max = coupon.maxRedemptions {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.rollUpLightGray)
                            .frame(height: 4)
                        Capsule()
                            .fill(Color.rollUpOrange)
                            .frame(width: geo.size.width * CGFloat(coupon.currentRedemptions) / CGFloat(max), height: 4)
                    }
                }
                .frame(height: 4)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        CouponManagementView()
    }
}
