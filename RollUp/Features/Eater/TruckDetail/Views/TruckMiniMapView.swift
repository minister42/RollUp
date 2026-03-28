import SwiftUI
import MapKit

struct TruckMiniMapView: View {
    let truck: FoodTruck

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Location", icon: "mappin.and.ellipse")

            Map {
                Annotation(truck.name, coordinate: truck.coordinate.clCoordinate) {
                    TruckAnnotationView(truck: truck)
                }
            }
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .allowsHitTesting(false)

            if truck.tier == .pro && truck.isOpen {
                HStack(spacing: 6) {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                        .font(.caption)
                        .foregroundStyle(.rollUpGreen)
                    Text("Live location tracking active")
                        .font(.caption)
                        .foregroundStyle(.rollUpGreen)
                }
            }
        }
    }
}

#Preview {
    TruckMiniMapView(truck: SampleData.trucks[0])
        .padding()
}
