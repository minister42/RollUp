import Foundation

@MainActor
final class TruckService: ObservableObject {
    private let apiClient: APIClient
    
    nonisolated init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    // MARK: - Truck Methods
    
    func getAllTrucks() async throws -> [FoodTruck] {
        let endpoint = APIEndpoints.Trucks.getAllTrucks
        return try await apiClient.request(endpoint: endpoint, responseType: [FoodTruck].self)
    }
    
    func getTruck(truckId: String) async throws -> FoodTruck {
        let endpoint = APIEndpoints.Trucks.getTruck(truckId: truckId)
        return try await apiClient.request(endpoint: endpoint, responseType: FoodTruck.self)
    }
    
    func createTruck(
        name: String,
        description: String,
        cuisine: String,
        ownerId: String,
        logoURL: URL? = nil,
        bannerURL: URL? = nil
    ) async throws -> FoodTruck {
        let request = TruckCreateRequest(
            name: name,
            description: description,
            cuisine: cuisine,
            ownerId: ownerId,
            logoURL: logoURL,
            bannerURL: bannerURL
        )
        let endpoint = APIEndpoints.Trucks.createTruck(truck: request)
        return try await apiClient.request(endpoint: endpoint, responseType: FoodTruck.self)
    }
    
    func updateTruck(
        truckId: String,
        name: String? = nil,
        description: String? = nil,
        cuisine: String? = nil,
        logoURL: URL? = nil,
        bannerURL: URL? = nil,
        isActive: Bool? = nil
    ) async throws -> FoodTruck {
        let updates = TruckUpdateRequest(
            name: name,
            description: description,
            cuisine: cuisine,
            logoURL: logoURL,
            bannerURL: bannerURL,
            isActive: isActive
        )
        let endpoint = APIEndpoints.Trucks.updateTruck(truckId: truckId, updates: updates)
        return try await apiClient.request(endpoint: endpoint, responseType: FoodTruck.self)
    }
    
    func deleteTruck(truckId: String) async throws {
        let endpoint = APIEndpoints.Trucks.deleteTruck(truckId: truckId)
        try await apiClient.request(endpoint: endpoint)
    }
    
    func getTrucksByOwner(ownerId: String) async throws -> [FoodTruck] {
        let endpoint = APIEndpoints.Trucks.getTrucksByOwner(ownerId: ownerId)
        return try await apiClient.request(endpoint: endpoint, responseType: [FoodTruck].self)
    }
    
    func searchTrucks(query: String, location: String? = nil) async throws -> [FoodTruck] {
        let endpoint = APIEndpoints.Trucks.searchTrucks(query: query, location: location)
        return try await apiClient.request(endpoint: endpoint, responseType: [FoodTruck].self)
    }
}
