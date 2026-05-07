import Foundation

// MARK: - Authentication Request/Response Models

struct SignInRequest: Codable {
    let email: String
    let password: String
}

struct SignUpRequest: Codable {
    let email: String
    let password: String
    let displayName: String
    let role: UserRole
}

struct AuthResponse: Codable {
    let user: User
    let accessToken: String
    let refreshToken: String
}

// MARK: - User Request Models

struct UserUpdateRequest: Codable {
    let displayName: String?
    let avatarURL: URL?
    let email: String?
}

// MARK: - Truck Request Models

struct TruckCreateRequest: Codable {
    let name: String
    let description: String
    let cuisine: String
    let ownerId: String
    let logoURL: URL?
    let bannerURL: URL?
}

struct TruckUpdateRequest: Codable {
    let name: String?
    let description: String?
    let cuisine: String?
    let logoURL: URL?
    let bannerURL: URL?
    let isActive: Bool?
}

// MARK: - Review Request Models

struct ReviewCreateRequest: Codable {
    let userId: String
    let rating: Int
    let comment: String?
}

struct ReviewUpdateRequest: Codable {
    let rating: Int?
    let comment: String?
}

// MARK: - Generic Response Wrappers

struct MessageResponse: Codable {
    let message: String
}

struct PaginatedResponse<T: Codable>: Codable {
    let items: [T]
    let total: Int
    let page: Int
    let pageSize: Int
    let hasMore: Bool
}
