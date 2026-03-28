import SwiftUI

struct SectionHeader: View {
    let title: String
    let icon: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(.rollUpOrange)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        SectionHeader(title: "Menu", icon: "menucard")
        SectionHeader(title: "Reviews", icon: "star.bubble.fill")
        SectionHeader(title: "Connect", icon: "link")
        SectionHeader(title: "Location", icon: "mappin.and.ellipse")
    }
    .padding()
}
