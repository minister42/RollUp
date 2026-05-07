# Backend Integration Guide

This document outlines the backend architecture and how to use the API services in your food truck app.

## Architecture Overview

The backend integration follows a clean, modular architecture with the following components:

### Core Components

1. **APIClient** - Low-level HTTP client with authentication support
2. **APIEndpoints** - Type-safe endpoint definitions
3. **APIModels** - Request/response data models
4. **APIError** - Centralized error handling
5. **Services** - Domain-specific business logic layers

### Services

- **AuthService** - Authentication and session management
- **UserService** - User profile operations
- **TruckService** - Food truck CRUD operations
- **ReviewService** - Review management
- **FavoriteService** - User favorites

## Quick Start

### 1. Configure Your Backend URL

Update the base URL in `APIClient.swift`:

```swift
self.baseURL = URL(string: "https://api.yourfoodtruckapp.com/v1")!
```

### 2. Sign In a User

```swift
@EnvironmentObject var appState: AppState

// In your view
Task {
    await appState.signIn(
        email: "user@example.com",
        password: "password123"
    )
}
```

### 3. Fetch Data

```swift
@StateObject private var truckService = TruckService()

Task {
    do {
        let trucks = try await truckService.getAllTrucks()
        // Use your trucks data
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
```

## Usage Examples

### Authentication

#### Sign Up
```swift
await appState.signUp(
    email: "newuser@example.com",
    password: "securePassword123",
    displayName: "John Doe",
    role: .eater
)
```

#### Sign In
```swift
await appState.signIn(
    email: "user@example.com",
    password: "password123"
)
```

#### Sign Out
```swift
await appState.signOut()
```

#### Load Saved Session
```swift
// Call this when your app launches
await appState.loadSavedSession()
```

### Truck Operations

#### Get All Trucks
```swift
let trucks = try await truckService.getAllTrucks()
```

#### Get Single Truck
```swift
let truck = try await truckService.getTruck(truckId: "truck-123")
```

#### Create Truck (Owner Only)
```swift
let newTruck = try await truckService.createTruck(
    name: "Taco Paradise",
    description: "Authentic Mexican street tacos",
    cuisine: "Mexican",
    ownerId: currentUser.id,
    logoURL: URL(string: "https://example.com/logo.png")
)
```

#### Update Truck
```swift
let updatedTruck = try await truckService.updateTruck(
    truckId: "truck-123",
    name: "New Name",
    description: "Updated description",
    isActive: true
)
```

#### Delete Truck
```swift
try await truckService.deleteTruck(truckId: "truck-123")
```

#### Search Trucks
```swift
let results = try await truckService.searchTrucks(
    query: "tacos",
    location: "San Francisco"
)
```

#### Get Trucks by Owner
```swift
let myTrucks = try await truckService.getTrucksByOwner(ownerId: currentUser.id)
```

### Review Operations

#### Get Truck Reviews
```swift
let reviews = try await reviewService.getTruckReviews(truckId: "truck-123")
```

#### Create Review
```swift
let review = try await reviewService.createReview(
    truckId: "truck-123",
    userId: currentUser.id,
    rating: 5,
    comment: "Amazing food! Highly recommend."
)
```

#### Update Review
```swift
let updated = try await reviewService.updateReview(
    reviewId: "review-456",
    rating: 4,
    comment: "Updated my review"
)
```

#### Delete Review
```swift
try await reviewService.deleteReview(reviewId: "review-456")
```

### Favorite Operations

#### Get User Favorites
```swift
let favorites = try await favoriteService.getUserFavorites(userId: currentUser.id)
```

#### Add Favorite
```swift
let response = try await favoriteService.addFavorite(
    userId: currentUser.id,
    truckId: "truck-123"
)
```

#### Remove Favorite
```swift
let response = try await favoriteService.removeFavorite(
    userId: currentUser.id,
    truckId: "truck-123"
)
```

#### Toggle Favorite
```swift
try await favoriteService.toggleFavorite(
    userId: currentUser.id,
    truckId: "truck-123",
    isFavorite: currentIsFavorite
)
```

## Error Handling

All service methods throw `APIError` which provides localized descriptions:

```swift
do {
    let trucks = try await truckService.getAllTrucks()
} catch let error as APIError {
    switch error {
    case .unauthorized:
        // Handle unauthorized - maybe sign out user
        break
    case .networkError(let underlyingError):
        // Handle network issues
        break
    case .serverError(let statusCode):
        // Handle server errors
        break
    default:
        // Handle other errors
        print(error.localizedDescription)
    }
} catch {
    // Handle unexpected errors
    print(error.localizedDescription)
}
```

## AppState Integration

The `AppState` class has been updated to integrate with the backend services:

- **Async sign in/sign up** - Communicates with backend
- **Session persistence** - Saves and loads authentication tokens
- **Error handling** - Exposes `errorMessage` and `isLoading` states
- **Backward compatibility** - Legacy `signIn(user:)` method still available for previews

### Using AppState in Views

```swift
struct MyView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            if appState.isLoading {
                ProgressView()
            }
            
            if let error = appState.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }
            
            if appState.isAuthenticated {
                Text("Welcome, \(appState.currentUser?.displayName ?? "")")
            }
        }
    }
}
```

## Authentication Token Management

Tokens are automatically managed by `APIClient`:

- **Access Token**: Stored in UserDefaults and included in all authenticated requests
- **Refresh Token**: Currently stored in UserDefaults (TODO: move to Keychain for production)

### Token Flow

1. User signs in → Backend returns access + refresh tokens
2. Access token saved and included in Authorization header
3. When access token expires, call `authService.refreshToken()`
4. New tokens are automatically saved and used

## TODO: Production Readiness

Before going to production, implement these improvements:

### Security
- [ ] Move refresh token storage from UserDefaults to Keychain
- [ ] Implement SSL certificate pinning
- [ ] Add request signing for sensitive operations
- [ ] Implement biometric authentication

### Error Handling
- [ ] Add retry logic for network failures
- [ ] Implement exponential backoff
- [ ] Add network reachability checking

### Performance
- [ ] Implement request caching
- [ ] Add request debouncing for search
- [ ] Implement pagination for large lists

### Testing
- [ ] Write unit tests for services
- [ ] Create mock API client for testing
- [ ] Add integration tests

## API Endpoint Reference

### Authentication Endpoints
- `POST /auth/signin` - Sign in user
- `POST /auth/signup` - Create new account
- `POST /auth/signout` - Sign out user
- `POST /auth/refresh` - Refresh access token

### User Endpoints
- `GET /users/me` - Get current user
- `GET /users/:id` - Get user by ID
- `PATCH /users/:id` - Update user profile
- `DELETE /users/:id` - Delete user account

### Truck Endpoints
- `GET /trucks` - Get all trucks
- `GET /trucks/:id` - Get truck by ID
- `POST /trucks` - Create truck
- `PATCH /trucks/:id` - Update truck
- `DELETE /trucks/:id` - Delete truck
- `GET /trucks/owner/:ownerId` - Get trucks by owner
- `GET /trucks/search?q=query&location=loc` - Search trucks

### Review Endpoints
- `GET /trucks/:truckId/reviews` - Get truck reviews
- `POST /trucks/:truckId/reviews` - Create review
- `PATCH /reviews/:id` - Update review
- `DELETE /reviews/:id` - Delete review

### Favorite Endpoints
- `GET /users/:userId/favorites` - Get user favorites
- `POST /users/:userId/favorites/:truckId` - Add favorite
- `DELETE /users/:userId/favorites/:truckId` - Remove favorite

## Example Implementation

See `BackendUsageExampleView.swift` for a complete working example of all backend operations.

## Support

For issues or questions about the backend integration, please consult the API documentation at your backend URL + `/docs`.
