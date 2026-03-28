import SwiftUI

struct SocialLinksView: View {
    let links: SocialLinks

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Connect", icon: "link")

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 10) {
                if let instagram = links.instagram {
                    SocialLinkButton(
                        icon: "camera.fill",
                        label: "Instagram",
                        color: .purple,
                        url: instagram
                    )
                }

                if let twitter = links.twitter {
                    SocialLinkButton(
                        icon: "at",
                        label: "Twitter",
                        color: .blue,
                        url: twitter
                    )
                }

                if let facebook = links.facebook {
                    SocialLinkButton(
                        icon: "person.2.fill",
                        label: "Facebook",
                        color: .indigo,
                        url: facebook
                    )
                }

                if let website = links.website {
                    SocialLinkButton(
                        icon: "globe",
                        label: "Website",
                        color: .rollUpOrange,
                        url: website
                    )
                }

                if let phone = links.phone {
                    SocialLinkButton(
                        icon: "phone.fill",
                        label: "Call",
                        color: .green,
                        url: URL(string: "tel:\(phone.replacingOccurrences(of: " ", with: ""))")!
                    )
                }
            }
        }
    }
}

struct SocialLinkButton: View {
    let icon: String
    let label: String
    let color: Color
    let url: URL

    var body: some View {
        Link(destination: url) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundStyle(color)
                    .frame(width: 28, height: 28)
                    .background(color.opacity(0.12), in: Circle())

                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.rollUpCharcoal)

                Spacer()

                Image(systemName: "arrow.up.right")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .padding(10)
            .background(Color.rollUpLightGray, in: RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    SocialLinksView(links: SocialLinks.preview)
        .padding()
}
