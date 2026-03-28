import Foundation
import SwiftUI

enum CuisineType: String, Codable, CaseIterable, Identifiable {
    case mexican = "Mexican"
    case bbq = "BBQ"
    case asian = "Asian"
    case korean = "Korean"
    case italian = "Italian"
    case seafood = "Seafood"
    case american = "American"
    case vegan = "Vegan"
    case dessert = "Dessert"
    case fusion = "Fusion"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .mexican: return "🌮"
        case .bbq: return "🍖"
        case .asian: return "🍜"
        case .korean: return "🍚"
        case .italian: return "🍕"
        case .seafood: return "🦐"
        case .american: return "🍔"
        case .vegan: return "🥗"
        case .dessert: return "🍩"
        case .fusion: return "🍱"
        }
    }

    var color: Color {
        switch self {
        case .mexican: return .orange
        case .bbq: return .red
        case .asian: return .yellow
        case .korean: return .pink
        case .italian: return .green
        case .seafood: return .cyan
        case .american: return .blue
        case .vegan: return .mint
        case .dessert: return .purple
        case .fusion: return .indigo
        }
    }
}
