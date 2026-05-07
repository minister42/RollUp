import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

extension APIEndpoint {
    var queryItems: [URLQueryItem]? { nil }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
}

enum APIEndpoints {
    // MARK: - Authentication
    enum Auth {
        case signIn(email: String, password: String)
        case signUp(email: String, password: String, displayName: String, role: UserRole)
        case signOut
        case refreshToken
    }
    
    // MARK: - User
    enum User {
        case getCurrentUser
        case updateProfile(userId: String, updates: UserUpdateRequest)
        case getUser(userId: String)
        case deleteAccount(userId: String)
    }
    
    // MARK: - Trucks
    enum Trucks {
        case getAllTrucks
        case getTruck(truckId: String)
        case createTruck(truck: TruckCreateRequest)
        case updateTruck(truckId: String, updates: TruckUpdateRequest)
        case deleteTruck(truckId: String)
        case getTrucksByOwner(ownerId: String)
        case searchTrucks(query: String, location: String?)
    }
    
    // MARK: - Reviews
    enum Reviews {
        case getTruckReviews(truckId: String)
        case createReview(truckId: String, review: ReviewCreateRequest)
        case updateReview(reviewId: String, updates: ReviewUpdateRequest)
        case deleteReview(reviewId: String)
    }
    
    // MARK: - Favorites
    enum Favorites {
        case getUserFavorites(userId: String)
        case addFavorite(userId: String, truckId: String)
        case removeFavorite(userId: String, truckId: String)
    }
}

// MARK: - Auth Endpoints
extension APIEndpoints.Auth: APIEndpoint {
    var path: String {
        switch self {
        case .signIn:
            return "/auth/signin"
        case .signUp:
            return "/auth/signup"
        case .signOut:
            return "/auth/signout"
        case .refreshToken:
            return "/auth/refresh"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signIn, .signUp, .signOut, .refreshToken:
            return .post
        }
    }
    
    var body: Data? {
        switch self {
        case .signIn(let email, let password):
            return try? JSONEncoder().encode(SignInRequest(email: email, password: password))
        case .signUp(let email, let password, let displayName, let role):
            return try? JSONEncoder().encode(SignUpRequest(email: email, password: password, displayName: displayName, role: role))
        case .signOut, .refreshToken:
            return nil
        }
    }
}

// MARK: - User Endpoints
extension APIEndpoints.User: APIEndpoint {
    var path: String {
        switch self {
        case .getCurrentUser:
            return "/users/me"
        case .updateProfile(let userId, _):
            return "/users/\(userId)"
        case .getUser(let userId):
            return "/users/\(userId)"
        case .deleteAccount(let userId):
            return "/users/\(userId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCurrentUser, .getUser:
            return .get
        case .updateProfile:
            return .patch
        case .deleteAccount:
            return .delete
        }
    }
    
    var body: Data? {
        switch self {
        case .updateProfile(_, let updates):
            return try? JSONEncoder().encode(updates)
        case .getCurrentUser, .getUser, .deleteAccount:
            return nil
        }
    }
}

// MARK: - Trucks Endpoints
extension APIEndpoints.Trucks: APIEndpoint {
    var path: String {
        switch self {
        case .getAllTrucks:
            return "/trucks"
        case .getTruck(let truckId):
            return "/trucks/\(truckId)"
        case .createTruck:
            return "/trucks"
        case .updateTruck(let truckId, _):
            return "/trucks/\(truckId)"
        case .deleteTruck(let truckId):
            return "/trucks/\(truckId)"
        case .getTrucksByOwner(let ownerId):
            return "/trucks/owner/\(ownerId)"
        case .searchTrucks:
            return "/trucks/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllTrucks, .getTruck, .getTrucksByOwner, .searchTrucks:
            return .get
        case .createTruck:
            return .post
        case .updateTruck:
            return .patch
        case .deleteTruck:
            return .delete
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchTrucks(let query, let location):
            var items = [URLQueryItem(name: "q", value: query)]
            if let location = location {
                items.append(URLQueryItem(name: "location", value: location))
            }
            return items
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createTruck(let truck):
            return try? JSONEncoder().encode(truck)
        case .updateTruck(_, let updates):
            return try? JSONEncoder().encode(updates)
        default:
            return nil
        }
    }
}

// MARK: - Reviews Endpoints
extension APIEndpoints.Reviews: APIEndpoint {
    var path: String {
        switch self {
        case .getTruckReviews(let truckId):
            return "/trucks/\(truckId)/reviews"
        case .createReview(let truckId, _):
            return "/trucks/\(truckId)/reviews"
        case .updateReview(let reviewId, _):
            return "/reviews/\(reviewId)"
        case .deleteReview(let reviewId):
            return "/reviews/\(reviewId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTruckReviews:
            return .get
        case .createReview:
            return .post
        case .updateReview:
            return .patch
        case .deleteReview:
            return .delete
        }
    }
    
    var body: Data? {
        switch self {
        case .createReview(_, let review):
            return try? JSONEncoder().encode(review)
        case .updateReview(_, let updates):
            return try? JSONEncoder().encode(updates)
        default:
            return nil
        }
    }
}

// MARK: - Favorites Endpoints
extension APIEndpoints.Favorites: APIEndpoint {
    var path: String {
        switch self {
        case .getUserFavorites(let userId):
            return "/users/\(userId)/favorites"
        case .addFavorite(let userId, let truckId):
            return "/users/\(userId)/favorites/\(truckId)"
        case .removeFavorite(let userId, let truckId):
            return "/users/\(userId)/favorites/\(truckId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUserFavorites:
            return .get
        case .addFavorite:
            return .post
        case .removeFavorite:
            return .delete
        }
    }
}
