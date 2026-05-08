import SwiftUI

// VanGo brand palette — "Sunflowers & Starlight"
//
// Inspired by Van Gogh's Sunflowers (1888) and Starry Night (1889): chrome
// yellow that stimulates appetite, cobalt blue that anchors as premium and
// trustworthy, and warm canvas whites that read as considered rather than
// stark. Terracotta and olive give us urgency and freshness without leaving
// the post-Impressionist colour system.
extension Color {
    // Primary brand
    static let vangoSun        = Color(red: 0.961, green: 0.722, blue: 0.180) // #F5B82E — sunflower / primary CTAs
    static let vangoCobalt     = Color(red: 0.118, green: 0.227, blue: 0.541) // #1E3A8A — secondary / depth / headers
    static let vangoStarlight  = Color(red: 0.231, green: 0.357, blue: 0.859) // #3B5BDB — links / active states

    // Surfaces & text
    static let vangoCanvas     = Color(red: 0.980, green: 0.965, blue: 0.910) // #FAF6E8 — aged-paper background
    static let vangoInk        = Color(red: 0.122, green: 0.122, blue: 0.180) // #1F1F2E — primary text (slight blue tint)

    // Status & semantics
    static let vangoTerracotta = Color(red: 0.784, green: 0.333, blue: 0.239) // #C8553D — alert / urgency / warm error
    static let vangoOlive      = Color(red: 0.478, green: 0.549, blue: 0.361) // #7A8C5C — fresh / open / healthy

    // Neutrals
    static let vangoSlate      = Color(red: 0.361, green: 0.388, blue: 0.471) // #5C6378 — secondary text / borders
    static let vangoMist       = Color(red: 0.949, green: 0.949, blue: 0.961) // #F2F2F5 — dividers / subtle surfaces

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
