import SwiftUI
import MapKit

struct DirectionsButton: View {
    let truck: FoodTruck

    var body: some View {
        Button {
            openDirections()
        } label: {
            Label("Get Directions", systemImage: "arrow.triangle.turn.up.right.diamond.fill")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.vangoSun, in: RoundedRectangle(cornerRadius: 14))
        }
    }

    private func openDirections() {
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: truck.coordinate.clCoordinate))
        destination.name = truck.name
        destination.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

#Preview {
    DirectionsButton(truck: SampleData.trucks[0])
        .padding()
}
