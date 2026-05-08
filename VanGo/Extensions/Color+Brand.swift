import SwiftUI

// VanGo brand palette — "Sunflowers & Starlight"
//
// Inspired by Van Gogh's Sunflowers (1888) and Starry Night (1889): chrome
// yellow that stimulates appetite, cobalt blue that anchors as premium and
// trustworthy, and warm canvas whites that read as considered rather than
// stark. Terracotta and olive give us urgency and freshness without leaving
// the post-Impressionist colour system.
//
// Colors are defined as named colorsets in `Assets.xcassets/Colors/` so they
// resolve dynamically against the system appearance. Light mode uses the
// canvas-on-ink palette; dark mode flips canvas → midnight (Starry Night sky)
// while accent colors brighten slightly to glow against the dark field.
extension Color {
    // Primary brand
    static let vangoSun        = Color("VangoSun")        // Sunflower yellow / primary CTAs
    static let vangoCobalt     = Color("VangoCobalt")     // Starry Night cobalt / depth
    static let vangoStarlight  = Color("VangoStarlight")  // Ultramarine / links / active

    // Surfaces & text
    static let vangoCanvas     = Color("VangoCanvas")     // Aged-paper background (cream → midnight)
    static let vangoInk        = Color("VangoInk")        // Primary text (ink → canvas)

    // Status & semantics
    static let vangoTerracotta = Color("VangoTerracotta") // Urgency / warm error
    static let vangoOlive      = Color("VangoOlive")      // Fresh / open / healthy

    // Neutrals
    static let vangoSlate      = Color("VangoSlate")      // Secondary text / borders
    static let vangoMist       = Color("VangoMist")       // Dividers / subtle surfaces

    // Brushstroke gradient — used sparingly on hero banners and premium CTAs
    static let vangoGradient = LinearGradient(
        colors: [vangoSun, vangoTerracotta],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension ShapeStyle where Self == Color {
    static var vangoSun: Color        { .vangoSun }
    static var vangoCobalt: Color     { .vangoCobalt }
    static var vangoStarlight: Color  { .vangoStarlight }
    static var vangoCanvas: Color     { .vangoCanvas }
    static var vangoInk: Color        { .vangoInk }
    static var vangoTerracotta: Color { .vangoTerracotta }
    static var vangoOlive: Color      { .vangoOlive }
    static var vangoSlate: Color      { .vangoSlate }
    static var vangoMist: Color       { .vangoMist }
}
