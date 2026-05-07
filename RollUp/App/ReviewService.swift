import Foundation

// Review model for backend communication
struct Review: Identifiable, Codable {
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
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    // MARK: - Review Methods
    
    func getTruckReviews(truckId: String) async throws -> [Review] {
        let endpoint = APIEndpoints.Reviews.getTruckReviews(truckId: truckId)
        return try await apiClient.request(endpoint: endpoint, responseType: [Review].self)
    }
    
    func createReview(
        truckId: String,
        userId: String,
        rating: Int,
        comment: String? = nil
    ) async throws -> Review {
        let request = ReviewCreateRequest(
            userId: userId,
            rating: rating,
            comment: comment
        )
        let endpoint = APIEndpoints.Reviews.createReview(truckId: truckId, review: request)
        return try await apiClient.request(endpoint: endpoint, responseType: Review.self)
    }
    
    func updateReview(
        reviewId: String,
        rating: Int? = nil,
        comment: String? = nil
    ) async throws -> Review {
        let updates = ReviewUpdateRequest(rating: rating, comment: comment)
        let endpoint = APIEndpoints.Reviews.updateReview(reviewId: reviewId, updates: updates)
        return try await apiClient.request(endpoint: endpoint, responseType: Review.self)
    }
    
    func deleteReview(reviewId: String) async throws {
        let endpoint = APIEndpoints.Reviews.deleteReview(reviewId: reviewId)
        try await apiClient.request(endpoint: endpoint)
    }
}
