import SwiftUI
import MapKit

struct TruckDetailView: View {
    let truck: FoodTruck
    @State private var showWriteReview = false

    private var menuItems: [MenuItem] {
        SampleData.menuItems(forTruck: truck.id)
    }

    private var reviews: [Review] {
        SampleData.reviews(forTruck: truck.id)
    }

    private var coupons: [Coupon] {
        SampleData.coupons(forTruck: truck.id)
    }

    private var menuCategories: [String] {
        Array(Set(menuItems.map(\.category))).sorted()
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Hero Image
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [truck.cuisineType.color.opacity(0.4), truck.cuisineType.color.opacity(0.7)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 220)
                        .overlay {
                            Text(truck.cuisineType.icon)
                                .font(.system(size: 80))
                                .opacity(0.6)
                        }

                    // Gradient overlay
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.5)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 100)
                    .frame(maxHeight: .infinity, alignment: .bottom)

                    // Truck name overlay
                    VStack(alignment: .leading, spacing: 4) {
                        if truck.isPromoted {
                            PromotedBadge()
                        }
                        Text(truck.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .padding(16)
                }

                VStack(spacing: 24) {
                    // Info bar
                    TruckInfoBar(truck: truck)

                    // Directions button
                    DirectionsButton(truck: truck)

                    // Menu section
                    if !menuItems.isEmpty {
                        MenuSectionView(categories: menuCategories, items: menuItems)
                    }

                    // Coupons section
                    if !coupons.isEmpty {
                        CouponsSectionView(coupons: coupons)
                    }

                    // Reviews section
                    ReviewsSectionView(
                        reviews: reviews,
                        averageRating: truck.averageRating,
                        reviewCount: truck.reviewCount,
                        onWriteReview: { showWriteReview = true }
                    )

                    // Social / Contact
                    SocialLinksView(links: truck.socialLinks)

                    // Mini Map
                    TruckMiniMapView(truck: truck)
                }
                .padding(16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 12) {
                    Button { } label: {
                        Image(systemName: "heart")
                            .foregroundStyle(.vangoInk)
                    }
                    Button { } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.vangoInk)
                    }
                }
            }
        }
        .sheet(isPresented: $showWriteReview) {
            WriteReviewView(truckName: truck.name)
        }
    }
}

struct TruckInfoBar: View {
    let truck: FoodTruck

    var body: some View {
        HStack(spacing: 16) {
            StatusBadge(isOpen: truck.isOpen)

            HStack(spacing: 3) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text(String(format: "%.1f", truck.averageRating))
                    .fontWeight(.semibold)
                Text("(\(truck.reviewCount) reviews)")
                    .foregroundStyle(.secondary)
            }
            .font(.subheadline)

            Spacer()

            HStack(spacing: 3) {
                Image(systemName: "location.fill")
                    .font(.caption)
                Text(String(format: "%.1f mi", SampleData.userLocation.distanceMiles(to: truck.coordinate)))
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        TruckDetailView(truck: SampleData.trucks[0])
    }
}
