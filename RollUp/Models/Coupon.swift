import Foundation

struct Coupon: Identifiable, Codable, Equatable {
    let id: String
    let truckId: String
    var truckName: String
    var code: String
    var description: String
    var discountType: DiscountType
    var discountValue: Double
    var expiresAt: Date
    var maxRedemptions: Int?
    var currentRedemptions: Int
    var revenueSharePercent: Double
    var isActive: Bool

    var discountDisplay: String {
        switch discountType {
        case .percentage:
            return "\(Int(discountValue))% OFF"
        case .fixedAmount:
            return "$\(Int(discountValue)) OFF"
        }
    }

    var isExpired: Bool {
        expiresAt < Date()
    }
}

enum DiscountType: String, Codable, CaseIterable {
    case percentage
    case fixedAmount

    var displayName: String {
        switch self {
        case .percentage: return "Percentage"
        case .fixedAmount: return "Fixed Amount"
        }
    }
}
