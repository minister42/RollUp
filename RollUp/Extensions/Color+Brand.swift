import SwiftUI

extension Color {
    // Primary brand colors
    static let rollUpOrange = Color(red: 1.0, green: 0.42, blue: 0.11)    // #FF6B1C
    static let rollUpRed = Color(red: 0.89, green: 0.22, blue: 0.21)      // #E33835
    static let rollUpCharcoal = Color(red: 0.18, green: 0.18, blue: 0.20) // #2E2E33
    static let rollUpCream = Color(red: 1.0, green: 0.97, blue: 0.93)     // #FFF8EE

    // Supporting colors
    static let rollUpGreen = Color(red: 0.22, green: 0.78, blue: 0.45)    // #38C773 (open status)
    static let rollUpGray = Color(red: 0.56, green: 0.56, blue: 0.58)     // #8F8F94
    static let rollUpLightGray = Color(red: 0.95, green: 0.95, blue: 0.96) // #F2F2F5

    // Gradient
    static let rollUpGradient = LinearGradient(
        colors: [rollUpOrange, rollUpRed],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension ShapeStyle where Self == Color {
    static var rollUpOrange: Color { .rollUpOrange }
    static var rollUpRed: Color { .rollUpRed }
    static var rollUpCharcoal: Color { .rollUpCharcoal }
    static var rollUpCream: Color { .rollUpCream }
    static var rollUpGreen: Color { .rollUpGreen }
    static var rollUpGray: Color { .rollUpGray }
    static var rollUpLightGray: Color { .rollUpLightGray }
}
