import Foundation

// API Review model for backend communication
struct APIReview: Identifiable, Codable {
    let id: String
    let truckId: String
    let userId: String
    let userName: String
    let userAvatarURL: URL?
    let rating: Int
    let comment: String?
    let createdAt: Date
    let updatedAt: Date
}

@MainActor
final class ReviewService: ObservableObject {
    private let apiClient: APIClient
    
    nonisolated init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    // MARK: - Review Methods
    
    func getTruckReviews(truckId: String) async throws -> [APIReview] {
        let endpoint = APIEndpoints.Reviews.getTruckReviews(truckId: truckId)
        return try await apiClient.request(endpoint: endpoint, responseType: [APIReview].self)
    }
    
    func createReview(
        truckId: String,
        userId: String,
        rating: Int,
        comment: String? = nil
    ) async throws -> APIReview {
        let request = ReviewCreateRequest(
            userId: userId,
            rating: rating,
            comment: comment
        )
        let endpoint = APIEndpoints.Reviews.createReview(truckId: truckId, review: request)
        return try await apiClient.request(endpoint: endpoint, responseType: APIReview.self)
    }
    
    func updateReview(
        reviewId: String,
        rating: Int? = nil,
        comment: String? = nil
    ) async throws -> APIReview {
        let updates = ReviewUpdateRequest(rating: rating, comment: comment)
        let endpoint = APIEndpoints.Reviews.updateReview(reviewId: reviewId, updates: updates)
        return try await apiClient.request(endpoint: endpoint, responseType: APIReview.self)
    }
    
    func deleteReview(reviewId: String) async throws {
        let endpoint = APIEndpoints.Reviews.deleteReview(reviewId: reviewId)
        try await apiClient.request(endpoint: endpoint)
    }
}
