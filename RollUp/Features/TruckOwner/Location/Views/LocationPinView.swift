import SwiftUI
import MapKit

struct LocationPinView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: SampleData.trucks[0].coordinate.clCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    @State private var pinCoordinate = SampleData.trucks[0].coordinate.clCoordinate

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Instructions
                VStack(spacing: 4) {
                    Text("Set Your Location")
                        .font(.headline)
                    Text("Drag the map to position your truck's pin")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))

                // Map with center pin
                ZStack {
                    Map(position: $cameraPosition)
                        .mapStyle(.standard)

                    // Center pin (stays fixed)
                    VStack(spacing: 0) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.rollUpOrange)
                            .shadow(radius: 4)

                        Circle()
                            .fill(.black.opacity(0.2))
                            .frame(width: 8, height: 4)
                    }
                }

                // Save button
                VStack(spacing: 8) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Save Location")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.rollUpOrange, in: RoundedRectangle(cornerRadius: 14))
                    }

                    Text("Your location will be shown to nearby users")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(16)
                .background(Color(.systemBackground))
            }
            .navigationTitle("Pin Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(.rollUpOrange)
                }
            }
        }
    }
}

#Preview {
    LocationPinView()
}
