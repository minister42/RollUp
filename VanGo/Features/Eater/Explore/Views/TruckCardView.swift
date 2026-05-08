import SwiftUI

struct TruckCardView: View {
    let truck: FoodTruck
    var distance: Double? // miles

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Hero Image area
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [truck.cuisineType.color.opacity(0.3), truck.cuisineType.color.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 140)
                    .overlay {
                        VStack {
                            Text(truck.cuisineType.icon)
                                .font(.system(size: 48))
                            Text(truck.name)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                    }

                if truck.isPromoted {
                    PromotedBadge()
                        .padding(8)
                }
            }

            // Info
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(truck.name)
                        .font(.headline)
                        .foregroundStyle(Color.vangoInk)

                    Spacer()

                    StatusBadge(isOpen: truck.isOpen)
                }

                HStack(spacing: 12) {
                    // Rating
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundStyle(.yellow)
                        Text(String(format: "%.1f", truck.averageRating))
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text("(\(truck.reviewCount))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    // Cuisine
                    Text(truck.cuisineType.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    // Distance
                    if let distance {
                        Text(String(format: "%.1f mi", distance))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(12)
        }
        .cardStyle()
    }
}

#Preview {
    TruckCardView(truck: SampleData.trucks[0], distance: 0.3)
        .padding()
}
