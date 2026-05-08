import Foundation

struct AdPackage: Identifiable, Codable, Equatable {
    let id: String
    let truckId: String
    var name: String
    var description: String
    var price: Double
    var durationDays: Int
    var impressionsIncluded: Int
    var startDate: Date?
    var endDate: Date?
    var isActive: Bool

    var priceString: String {
        String(format: "$%.2f", price)
    }
}

enum AdPackageTemplate: String, CaseIterable, Identifiable {
    case spotlight = "Spotlight"
    case featured = "Featured"
    case premium = "Premium"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .spotlight: return "Appear in the Promoted section for 7 days"
        case .featured: return "Top of search results + Promoted for 14 days"
        case .premium: return "Featured placement + push notifications to nearby users for 30 days"
        }
    }

    var price: Double {
        switch self {
        case .spotlight: return 29.99
        case .featured: return 59.99
        case .premium: return 99.99
        }
    }

    var durationDays: Int {
        switch self {
        case .spotlight: return 7
        case .featured: return 14
        case .premium: return 30
        }
    }

    var impressions: Int {
        switch self {
        case .spotlight: return 5000
        case .featured: return 15000
        case .premium: return 50000
        }
    }

    var icon: String {
        switch self {
        case .spotlight: return "flashlight.on.fill"
        case .featured: return "star.fill"
        case .premium: return "crown.fill"
        }
    }
}
