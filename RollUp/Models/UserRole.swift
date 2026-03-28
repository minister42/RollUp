import Foundation

enum UserRole: String, Codable, CaseIterable {
    case eater
    case truckOwner

    var displayName: String {
        switch self {
        case .eater: return "Food Lover"
        case .truckOwner: return "Truck Owner"
        }
    }
}
