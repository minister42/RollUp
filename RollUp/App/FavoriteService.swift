import Foundation

@MainActor
final class FavoriteService: ObservableObject {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    // MARK: - Favorite Methods
    
    func getUserFavorites(userId: String) async throws -> [FoodTruck] {
        let endpoint = APIEndpoints.Favorites.getUserFavorites(userId: userId)
        return try await apiClient.request(endpoint: endpoint, responseType: [FoodTruck].self)
    }
    
    func addFavorite(userId: String, truckId: String) async throws -> MessageResponse {
        let endpoint = APIEndpoints.Favorites.addFavorite(userId: userId, truckId: truckId)
        return try await apiClient.request(endpoint: endpoint, responseType: MessageResponse.self)
    }
    
    func removeFavorite(userId: String, truckId: String) async throws -> MessageResponse {
        let endpoint = APIEndpoints.Favorites.removeFavorite(userId: userId, truckId: truckId)
        return try await apiClient.request(endpoint: endpoint, responseType: MessageResponse.self)
    }
    
    func toggleFavorite(userId: String, truckId: String, isFavorite: Bool) async throws {
        if isFavorite {
            _ = try await removeFavorite(userId: userId, truckId: truckId)
        } else {
            _ = try await addFavorite(userId: userId, truckId: truckId)
        }
    }
}
