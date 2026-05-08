import Foundation

/// Mock API Client for testing and development without a real backend
/// Use this when `APIConfiguration.enableMockData` is true
@MainActor
final class MockAPIClient {
    nonisolated(unsafe) static let shared = MockAPIClient()
    
    private nonisolated init() {}
    
    // MARK: - Mock Data
    
    private var mockUsers: [User] = [
        User.preview,
        User.previewOwner
    ]
    
    private var mockTrucks: [FoodTruck] = []
    
    private var mockReviews: [String: [APIReview]] = [:] // truckId: [APIReview]
    
    private var mockFavorites: [String: Set<String>] = [:] // userId: Set<truckId>
    
    // Current session
    private var currentAccessToken: String?
    
    // MARK: - Auth Methods
    
    func mockSignIn(email: String, password: String) async throws -> AuthResponse {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Find user by email
        guard let user = mockUsers.first(where: { $0.email == email }) else {
            throw APIError.unauthorized
        }
        
        // In real app, validate password. For mock, just check it's not empty
        guard !password.isEmpty else {
            throw APIError.unauthorized
        }
        
        let token = "mock-access-token-\(UUID().uuidString)"
        currentAccessToken = token
        
        return AuthResponse(
            user: user,
            accessToken: token,
            refreshToken: "mock-refresh-token-\(UUID().uuidString)"
        )
    }
    
    func mockSignUp(
        email: String,
        password: String,
        displayName: String,
        role: UserRole
    ) async throws -> AuthResponse {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000)
        
        // Check if user already exists
        if mockUsers.contains(where: { $0.email == email }) {
            throw APIError.serverError(statusCode: 409) // Conflict
        }
        
        let newUser = User(
            id: "user-\(UUID().uuidString)",
            email: email,
            displayName: displayName,
            role: role,
            avatarURL: nil,
            createdAt: Date()
        )
        
        mockUsers.append(newUser)
        
        let token = "mock-access-token-\(UUID().uuidString)"
        currentAccessToken = token
        
        return AuthResponse(
            user: newUser,
            accessToken: token,
            refreshToken: "mock-refresh-token-\(UUID().uuidString)"
        )
    }
    
    func mockSignOut() async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
        currentAccessToken = nil
    }
    
    // MARK: - User Methods
    
    func mockGetCurrentUser() async throws -> User {
        try await Task.sleep(nanoseconds: 300_000_000)
        
        guard currentAccessToken != nil else {
            throw APIError.unauthorized
        }
        
        // Return first user as current user for mock
        return mockUsers.first ?? User.preview
    }
    
    func mockGetUser(userId: String) async throws -> User {
        try await Task.sleep(nanoseconds: 300_000_000)
        
        guard let user = mockUsers.first(where: { $0.id == userId }) else {
            throw APIError.notFound
        }
        
        return user
    }
    
    func mockUpdateUser(userId: String, updates: UserUpdateRequest) async throws -> User {
        try await Task.sleep(nanoseconds: 400_000_000)
        
        guard let index = mockUsers.firstIndex(where: { $0.id == userId }) else {
            throw APIError.notFound
        }
        
        var user = mockUsers[index]
        if let displayName = updates.displayName {
            user.displayName = displayName
        }
        if let avatarURL = updates.avatarURL {
            user.avatarURL = avatarURL
        }
        if let email = updates.email {
            user.email = email
        }
        
        mockUsers[index] = user
        return user
    }
    
    // MARK: - Truck Methods
    
    func mockGetAllTrucks() async throws -> [FoodTruck] {
        try await Task.sleep(nanoseconds: 400_000_000)
        return mockTrucks
    }
    
    func mockGetTruck(truckId: String) async throws -> FoodTruck {
        try await Task.sleep(nanoseconds: 300_000_000)
        
        guard let truck = mockTrucks.first(where: { $0.id == truckId }) else {
            throw APIError.notFound
        }
        
        return truck
    }
    
    func mockSearchTrucks(query: String, location: String?) async throws -> [FoodTruck] {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        return mockTrucks.filter { truck in
            truck.name.localizedCaseInsensitiveContains(query) ||
            truck.description.localizedCaseInsensitiveContains(query)
        }
    }
    
    // MARK: - Review Methods
    
    func mockGetTruckReviews(truckId: String) async throws -> [APIReview] {
        try await Task.sleep(nanoseconds: 400_000_000)
        return mockReviews[truckId] ?? []
    }
    
    func mockCreateReview(
        truckId: String,
        userId: String,
        rating: Int,
        comment: String?
    ) async throws -> APIReview {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        let user = try await mockGetUser(userId: userId)
        
        let review = APIReview(
            id: "review-\(UUID().uuidString)",
            truckId: truckId,
            userId: userId,
            userName: user.displayName,
            userAvatarURL: user.avatarURL,
            rating: rating,
            comment: comment,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        var reviews = mockReviews[truckId] ?? []
        reviews.append(review)
        mockReviews[truckId] = reviews
        
        return review
    }
    
    // MARK: - Favorite Methods
    
    func mockGetUserFavorites(userId: String) async throws -> [FoodTruck] {
        try await Task.sleep(nanoseconds: 400_000_000)
        
        let favoriteIds = mockFavorites[userId] ?? []
        return mockTrucks.filter { favoriteIds.contains($0.id) }
    }
    
    func mockAddFavorite(userId: String, truckId: String) async throws {
        try await Task.sleep(nanoseconds: 300_000_000)
        
        var favorites = mockFavorites[userId] ?? []
        favorites.insert(truckId)
        mockFavorites[userId] = favorites
    }
    
    func mockRemoveFavorite(userId: String, truckId: String) async throws {
        try await Task.sleep(nanoseconds: 300_000_000)
        
        var favorites = mockFavorites[userId] ?? []
        favorites.remove(truckId)
        mockFavorites[userId] = favorites
    }
    
    // MARK: - Data Seeding
    
    func seedMockData(trucks: [FoodTruck]) {
        self.mockTrucks = trucks
    }
    
    func reset() {
        mockUsers = [User.preview, User.previewOwner]
        mockTrucks = []
        mockReviews = [:]
        mockFavorites = [:]
        currentAccessToken = nil
    }
}

// MARK: - Mock Service Extensions

extension AuthService {
    func signInMock(email: String, password: String) async throws -> AuthResponse {
        return try await MockAPIClient.shared.mockSignIn(email: email, password: password)
    }
}

extension TruckService {
    func getAllTrucksMock() async throws -> [FoodTruck] {
        return try await MockAPIClient.shared.mockGetAllTrucks()
    }
}
