import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @State private var selectedCuisines: Set<CuisineType> = []

    private var filteredTrucks: [FoodTruck] {
        var trucks = SampleData.trucks

        if !searchText.isEmpty {
            trucks = trucks.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.cuisineType.rawValue.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }

        if !selectedCuisines.isEmpty {
            trucks = trucks.filter { selectedCuisines.contains($0.cuisineType) }
        }

        return trucks
    }

    private var promotedTrucks: [FoodTruck] {
        filteredTrucks.filter { $0.isPromoted }
    }

    private var nearbyTrucks: [FoodTruck] {
        filteredTrucks.filter { !$0.isPromoted }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Search
                SearchBarView(text: $searchText)
                    .padding(.horizontal, 16)

                // Cuisine filters
                CuisineFilterView(selectedCuisines: $selectedCuisines)

                if filteredTrucks.isEmpty {
                    EmptyStateView(
                        icon: "magnifyingglass",
                        title: "No trucks found",
                        message: "Try adjusting your search or filters",
                        actionTitle: "Clear Filters"
                    ) {
                        searchText = ""
                        selectedCuisines = []
                    }
                    .frame(height: 300)
                } else {
                    // Promoted section
                    if !promotedTrucks.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "megaphone.fill")
                                    .foregroundStyle(.vangoSun)
                                Text("PROMOTED")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.vangoSun)
                            }
                            .padding(.horizontal, 16)

                            ForEach(promotedTrucks) { truck in
                                NavigationLink(value: truck) {
                                    TruckCardView(
                                        truck: truck,
                                        distance: SampleData.userLocation.distanceMiles(to: truck.coordinate)
                                    )
                                }
                                .buttonStyle(.plain)
                                .padding(.horizontal, 16)
                            }
                        }
                    }

                    // Nearby section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("NEARBY")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 16)

                        ForEach(nearbyTrucks) { truck in
                            NavigationLink(value: truck) {
                                TruckCardView(
                                    truck: truck,
                                    distance: SampleData.userLocation.distanceMiles(to: truck.coordinate)
                                )
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Explore")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 4) {
                    Image(systemName: "location.fill")
                        .font(.caption)
                    Text("Austin, TX")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .foregroundStyle(.vangoSun)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button { } label: {
                    Image(systemName: "bell.fill")
                        .foregroundStyle(.vangoInk)
                }
            }
        }
        .navigationDestination(for: FoodTruck.self) { truck in
            TruckDetailView(truck: truck)
        }
    }
}

#Preview {
    NavigationStack {
        ExploreView()
    }
    .environmentObject(AppState.previewEater)
}
