import SwiftUI

/// Brand reveal shown for ~1.5s after the iOS launch screen, before the main
/// app content. The brushstroke van composes itself painterly-fashion,
/// suggesting the brand's Van Gogh inspiration without spelling it out.
///
/// Usage: `RootView` shows `SplashView` while `appState.hasCompletedSplash`
/// is `false`, then transitions away when the splash signals completion via
/// the `onFinished` closure.
struct SplashView: View {
    /// Called when the splash animation finishes and the app should advance.
    let onFinished: () -> Void

    @State private var showMotionLines = false
    @State private var showVan = false
    @State private var showWordmark = false
    @State private var fadeOut = false

    var body: some View {
        ZStack {
            // Canvas-coloured field. In dark mode this becomes the
            // Starry-Night midnight; in light mode, aged paper.
            Color.vangoCanvas
                .ignoresSafeArea()

            VStack(spacing: 28) {
                // Brushstroke mark. The SVG asset is registered with
                // preserves-vector-representation so it scales sharply.
                Image("VanGoMark")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 320)
                    .scaleEffect(showVan ? 1 : 0.85)
                    .opacity(showVan ? 1 : 0)
                    .overlay(alignment: .leading) {
                        // Tiny terracotta motion lines that animate in first,
                        // suggesting the van is *arriving* before it settles.
                        VStack(alignment: .leading, spacing: 14) {
                            ForEach(0..<3, id: \.self) { i in
                                Capsule()
                                    .fill(Color.vangoTerracotta)
                                    .frame(width: showMotionLines ? 36 : 0, height: 6)
                                    .opacity(showMotionLines ? (1.0 - Double(i) * 0.25) : 0)
                                    .animation(
                                        .easeOut(duration: 0.45).delay(Double(i) * 0.08),
                                        value: showMotionLines
                                    )
                            }
                        }
                        .offset(x: -52, y: 0)
                    }

                Text("VanGo")
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .tracking(-1.5)
                    .foregroundStyle(.vangoInk)
                    .opacity(showWordmark ? 1 : 0)
                    .offset(y: showWordmark ? 0 : 8)
            }
            .padding(.horizontal, 40)
        }
        .opacity(fadeOut ? 0 : 1)
        .task {
            // Layered build-on: motion lines → van settles in → wordmark.
            withAnimation(.easeOut(duration: 0.4)) { showMotionLines = true }
            try? await Task.sleep(for: .milliseconds(180))
            withAnimation(.spring(response: 0.55, dampingFraction: 0.78)) { showVan = true }
            try? await Task.sleep(for: .milliseconds(420))
            withAnimation(.easeOut(duration: 0.35)) { showWordmark = true }

            // Hold the final composition briefly so the user can read it,
            // then fade out and signal the parent to advance.
            try? await Task.sleep(for: .milliseconds(900))
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
