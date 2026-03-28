import SwiftUI
import MapKit

struct TruckMapDetailSheet: View {
    let truck: FoodTruck

    var body: some View {
        VStack(spacing: 12) {
            // Drag indicator
            Capsule()
                .fill(Color.rollUpGray.opacity(0.4))
                .frame(width: 36, height: 5)
                .padding(.top, 8)

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(truck.name)
                            .font(.headline)
                        StatusBadge(isOpen: truck.isOpen)
                    }

                    HStack(spacing: 8) {
                        HStack(spacing: 3) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundStyle(.yellow)
                            Text(String(format: "%.1f", truck.averageRating))
                                .font(.subheadline)
                        }

                        Text(truck.cuisineType.rawValue)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Text(String(format: "%.1f mi", SampleData.userLocation.distanceMiles(to: truck.coordinate)))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                Text(truck.cuisineType.icon)
                    .font(.system(size: 36))
            }
            .padding(.horizontal, 16)

            HStack(spacing: 12) {
                NavigationLink(value: truck) {
                    Label("View Menu", systemImage: "menucard")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.rollUpOrange, in: RoundedRectangle(cornerRadius: 12))
                }

                Button {
                    openDirections(to: truck)
                } label: {
                    Label("Directions", systemImage: "arrow.triangle.turn.up.right.diamond.fill")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.rollUpOrange)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.rollUpOrange.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
    }

    private func openDirections(to truck: FoodTruck) {
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: truck.coordinate.clCoordinate))
        destination.name = truck.name
        destination.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

#Preview {
    TruckMapDetailSheet(truck: SampleData.trucks[0])
}
