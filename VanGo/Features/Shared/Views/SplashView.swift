import SwiftUI

/// Brand reveal shown for ~1.5s after the iOS launch screen, before the main
/// app content. A single elegant fade-in of the "vango" wordmark on a canvas
/// field — restrained, confident, no theatrics.
///
/// Usage: `RootView` shows `SplashView` until it signals completion via the
/// `onFinished` closure, then crossfades to the main app.
struct SplashView: View {
    /// Called when the splash animation finishes and the app should advance.
    let onFinished: () -> Void

    @State private var showWordmark = false
    @State private var fadeOut = false

    var body: some View {
        ZStack {
            // Canvas field: cream paper in light mode, midnight (Starry Night
            // sky) in dark mode. Resolves dynamically via the colorset.
            Color.vangoCanvas
                .ignoresSafeArea()

            // Wordmark — already includes the brushstroke underline as part
            // of the asset, so no extra layout needed.
            Image("VanGoMark")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 360)
                .padding(.horizontal, 40)
                .scaleEffect(showWordmark ? 1.0 : 0.94)
                .opacity(showWordmark ? 1 : 0)
        }
        .opacity(fadeOut ? 0 : 1)
        .task {
            // Quiet reveal: a subtle scale-up + fade-in feels like a page
            // turning, not a stagey animation.
            withAnimation(.easeOut(duration: 0.6)) { showWordmark = true }

            // Hold the final composition briefly so the user can read it.
            try? await Task.sleep(for: .milliseconds(900))

            // Fade to the main app.
            withAnimation(.easeIn(duration: 0.3)) { fadeOut = true }
            try? await Task.sleep(for: .milliseconds(320))
            onFinished()
        }
    }
}

#Preview("Splash — light") {
    SplashView(onFinished: {})
        .preferredColorScheme(.light)
}

#Preview("Splash — dark") {
    SplashView(onFinished: {})
        .preferredColorScheme(.dark)
}
