import Foundation

enum SubscriptionTier: String, Codable, CaseIterable, Identifiable {
    case basic
    case pro

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .basic: return "Basic"
        case .pro: return "Pro"
        }
    }

    var monthlyPrice: Decimal {
        switch self {
        case .basic: return 9.99
        case .pro: return 24.99
        }
    }

    var priceString: String {
        switch self {
        case .basic: return "$9.99/mo"
        case .pro: return "$24.99/mo"
        }
    }

    var allowsLiveTracking: Bool { self == .pro }
    var allowsOpenStatus: Bool { self == .pro }
    var priorityInSearch: Bool { self == .pro }

    var features: [FeatureItem] {
        switch self {
        case .basic:
            return [
                FeatureItem(name: "Listed on VanGo", included: true),
                FeatureItem(name: "Menu & profile", included: true),
                FeatureItem(name: "Customer reviews", included: true),
                FeatureItem(name: "Manual location pin", included: true),
                FeatureItem(name: "Live GPS tracking", included: false),
                FeatureItem(name: "\"Open\" status broadcast", included: false),
                FeatureItem(name: "Priority in search", included: false),
            ]
        case .pro:
            return [
                FeatureItem(name: "Everything in Basic", included: true),
                FeatureItem(name: "Live GPS tracking", included: true),
                FeatureItem(name: "\"Open for Business\" status", included: true),
                FeatureItem(name: "Priority in search results", included: true),
                FeatureItem(name: "Analytics dashboard", included: true),
            ]
        }
    }

    struct FeatureItem: Identifiable {
        let id = UUID()
        let name: String
        let included: Bool
    }
}
