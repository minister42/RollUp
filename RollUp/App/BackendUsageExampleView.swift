import SwiftUI

/// Example view demonstrating how to use the backend services
struct BackendUsageExampleView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var truckService = TruckService()
    @StateObject private var reviewService = ReviewService()
    @StateObject private var favoriteService = FavoriteService()
    
    @State private var trucks: [FoodTruck] = []
    @State private var reviews: [Review] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            List {
                Section("Authentication Examples") {
                    Button("Sign In Example") {
                        Task {
                            await signInExample()
                        }
                    }
                    
                    Button("Sign Up Example") {
                        Task {
                            await signUpExample()
                        }
                    }
                    
                    Button("Sign Out") {
                        Task {
                            await appState.signOut()
                        }
                    }
                }
                
                Section("Truck Operations") {
                    Button("Fetch All Trucks") {
                        Task {
                            await fetchTrucks()
                        }
                    }
                    
                    Button("Search Trucks") {
                        Task {
                            await searchTrucks()
                        }
                    }
                    
                    Button("Create Truck (Owner Only)") {
                        Task {
                            await createTruckExample()
                        }
                    }
                }
                
                Section("Review Operations") {
                    Button("Fetch Reviews") {
                        Task {
                            await fetchReviews()
                        }
                    }
                    
                    Button("Create Review") {
                        Task {
                            await createReviewExample()
                        }
                    }
                }
                
                Section("Favorite Operations") {
                    Button("Fetch Favorites") {
                        Task {
                            await fetchFavorites()
                        }
                    }
                }
                
                if isLoading {
                    Section {
                        ProgressView()
                    }
                }
                
                if let errorMessage = errorMessage {
                    Section("Error") {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Backend API Examples")
        }
    }
    
    // MARK: - Authentication Examples
    
    private func signInExample() async {
        await appState.signIn(
            email: "alex@example.com",
            password: "password123"
        )
    }
    
    private func signUpExample() async {
        await appState.signUp(
            email: "newuser@example.com",
            password: "password123",
            displayName: "New User",
            role: .eater
        )
    }
    
    // MARK: - Truck Examples
    
    private func fetchTrucks() async {
        isLoading = true
        errorMessage = nil
        
        do {
            trucks = try await truckService.getAllTrucks()
            print("✅ Fetched \(trucks.count) trucks")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error fetching trucks: \(error)")
        }
        
        isLoading = false
    }
    
    private func searchTrucks() async {
        isLoading = true
        errorMessage = nil
        
        do {
            trucks = try await truckService.searchTrucks(
                query: "tacos",
                location: "San Francisco"
            )
            print("✅ Found \(trucks.count) trucks matching search")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error searching trucks: \(error)")
        }
        
        isLoading = false
    }
    
    private func createTruckExample() async {
        guard let currentUser = appState.currentUser,
              currentUser.role == .truckOwner else {
            errorMessage = "Only truck owners can create trucks"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let newTruck = try await truckService.createTruck(
                name: "My New Truck",
                description: "Delicious food on wheels!",
                cuisine: "Mexican",
                ownerId: currentUser.id
            )
            print("✅ Created truck: \(newTruck.name)")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error creating truck: \(error)")
        }
        
        isLoading = false
    }
    
    // MARK: - Review Examples
    
    private func fetchReviews() async {
        isLoading = true
        errorMessage = nil
        
        // Example truck ID - replace with actual truck ID
        let truckId = "truck-001"
        
        do {
            reviews = try await reviewService.getTruckReviews(truckId: truckId)
            print("✅ Fetched \(reviews.count) reviews")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error fetching reviews: \(error)")
        }
        
        isLoading = false
    }
    
    private func createReviewExample() async {
        guard let currentUser = appState.currentUser else {
            errorMessage = "Must be signed in to create reviews"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Example truck ID - replace with actual truck ID
        let truckId = "truck-001"
        
        do {
            let review = try await reviewService.createReview(
                truckId: truckId,
                userId: currentUser.id,
                rating: 5,
                comment: "Amazing food!"
            )
            print("✅ Created review with rating: \(review.rating)")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error creating review: \(error)")
        }
        
        isLoading = false
    }
    
    // MARK: - Favorite Examples
    
    private func fetchFavorites() async {
        guard let currentUser = appState.currentUser else {
            errorMessage = "Must be signed in to fetch favorites"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let favorites = try await favoriteService.getUserFavorites(userId: currentUser.id)
            print("✅ Fetched \(favorites.count) favorite trucks")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error fetching favorites: \(error)")
        }
        
        isLoading = false
    }
}

#Preview {
    BackendUsageExampleView()
        .environmentObject(AppState.previewEater)
}
