import SwiftUI

struct CardModifier: ViewModifier {
    var cornerRadius: CGFloat = 16
    var shadowRadius: CGFloat = 4

    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.08), radius: shadowRadius, x: 0, y: 2)
    }
}

extension View {
    func cardStyle(cornerRadius: CGFloat = 16, shadowRadius: CGFloat = 4) -> some View {
        modifier(CardModifier(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
}
