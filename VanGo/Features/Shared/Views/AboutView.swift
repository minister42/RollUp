import SwiftUI

/// Brand "About" screen — accessible from the profile views. Shows the
/// "vango" wordmark prominently, the brand story in two short paragraphs,
/// version metadata, and links to legal/support resources.
///
/// The hero image is the same wordmark used in the splash so the brand
/// reads as continuous between launch and deeper navigation.
struct AboutView: View {
    @Environment(\.openURL) private var openURL

    private var appVersion: String {
        let bundle = Bundle.main
        let short = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        let build = bundle.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "v\(short) (\(build))"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                hero
                story
                meta
            }
        }
        .background(Color.vangoCanvas.ignoresSafeArea())
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Sections

    /// Hero — "vango" wordmark on a subtle Sun→Terracotta gradient wash.
    /// Sets the literary tone before the user reads any copy.
    private var hero: some View {
        ZStack {
            Color.vangoGradient
                .opacity(0.16)
                .frame(height: 240)

            Image("VanGoMark")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 280)
                .padding(.horizontal, 32)
        }
    }

    /// Two-paragraph brand story. Short on purpose — About screens are
    /// rarely read in full; the visual already did most of the work.
    private var story: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Time to VanGo.")
                .font(.title.weight(.bold))
                .foregroundStyle(.vangoInk)

            Text("VanGo connects you with the best food trucks in your city — in real time. Find them on the map, browse menus, score deals, and follow the trucks that keep you coming back.")
                .font(.body)
                .foregroundStyle(.vangoInk)

            Text("Inspired by Vincent's sunflowers and starry nights — because great food, like great art, has its own colour palette.")
                .font(.callout)
                .italic()
                .foregroundStyle(.vangoSlate)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }

    /// Version, links, credit. Grouped at the bottom in muted styles so
    /// the eye lands on the brand story first.
    private var meta: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.vangoMist)
                .padding(.vertical, 24)

            VStack(spacing: 16) {
                AboutLinkRow(icon: "doc.text",          title: "Terms of Service") {
                    openURL(URL(string: "https://vango.app/terms")!)
                }
                AboutLinkRow(icon: "lock.shield",       title: "Privacy Policy") {
                    openURL(URL(string: "https://vango.app/privacy")!)
                }
                AboutLinkRow(icon: "envelope",          title: "Contact Support") {
                    openURL(URL(string: "mailto:hello@vango.app")!)
                }
                AboutLinkRow(icon: "star",              title: "Rate VanGo on the App Store") {
                    openURL(URL(string: "https://apps.apple.com/app/idTBD")!)
                }
            }
            .padding(.horizontal, 24)

            VStack(spacing: 4) {
                Text("VanGo \(appVersion)")
                    .font(.caption)
                    .foregroundStyle(.vangoSlate)
                Text("Made with care for food truck lovers.")
                    .font(.caption2)
                    .foregroundStyle(.vangoSlate.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 32)
        }
    }
}

private struct AboutLinkRow: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.callout)
                    .foregroundStyle(.vangoCobalt)
                    .frame(width: 24)
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.vangoInk)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.vangoSlate.opacity(0.6))
            }
            .padding(.vertical, 10)
        }
    }
}

#Preview("About — light") {
    NavigationStack { AboutView() }.preferredColorScheme(.light)
}

#Preview("About — dark") {
    NavigationStack { AboutView() }.preferredColorScheme(.dark)
}
