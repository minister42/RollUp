import SwiftUI
import MapKit

struct MapExploreView: View {
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: SampleData.userLocation.clCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    )
    @State private var selectedTruck: FoodTruck?
    @State private var searchText = ""

    private var filteredTrucks: [FoodTruck] {
        if searchText.isEmpty {
            return SampleData.trucks
        }
        return SampleData.trucks.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.cuisineType.rawValue.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition, selection: $selectedTruck) {
                // User location
                Annotation("You", coordinate: SampleData.userLocation.clCoordinate) {
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 32, height: 32)
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 14, height: 14)
                            .overlay(
                                Circle().stroke(.white, lineWidth: 2)
                            )
                    }
                }

                // Truck annotations
                ForEach(filteredTrucks) { truck in
                    Annotation(truck.name, coordinate: truck.coordinate.clCoordinate, anchor: .bottom) {
                        TruckAnnotationView(truck: truck)
                            .onTapGesture {
                                withAnimation {
                                    selectedTruck = truck
                                }
                            }
                    }
                    .tag(truck)
                }
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            .ignoresSafeArea(edges: .bottom)

            // Search overlay
            SearchBarView(text: $searchText, placeholder: "Search this area...")
                .padding(.horizontal, 16)
                .padding(.top, 8)

            // Bottom detail sheet
            if let truck = selectedTruck {
                VStack {
                    Spacer()
                    TruckMapDetailSheet(truck: truck)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .navigationTitle("Map")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: FoodTruck.self) { truck in
            TruckDetailView(truck: truck)
        }
        .animation(.easeInOut(duration: 0.25), value: selectedTruck)
    }
}

#Preview {
    NavigationStack {
        MapExploreView()
    }
}
