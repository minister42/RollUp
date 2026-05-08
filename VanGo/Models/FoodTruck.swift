import Foundation

struct FoodTruck: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let ownerId: String
    var name: String
    var description: String
    var cuisineType: CuisineType
    var coordinate: Coordinate
    var isOpen: Bool
    var tier: SubscriptionTier
    var socialLinks: SocialLinks
    var heroImageName: String?
    var averageRating: Double
    var reviewCount: Int
    var isPromoted: Bool

    static func == (lhs: FoodTruck, rhs: FoodTruck) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
