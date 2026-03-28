import SwiftUI

struct MenuSectionView: View {
    let categories: [String]
    let items: [MenuItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Menu", icon: "menucard")

            ForEach(categories, id: \.self) { category in
                VStack(alignment: .leading, spacing: 8) {
                    Text(category.uppercased())
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)

                    ForEach(items.filter { $0.category == category }) { item in
                        MenuItemRow(item: item)
                    }
                }
            }
        }
    }
}

struct MenuItemRow: View {
    let item: MenuItem

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    Text(item.name)
                        .font(.subheadline)
                        .fontWeight(.medium)

                    if !item.isAvailable {
                        Text("Sold Out")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.red)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.red.opacity(0.1), in: Capsule())
                    }
                }

                Text(item.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            Text(item.priceString)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.rollUpCharcoal)
        }
        .padding(.vertical, 6)
        .opacity(item.isAvailable ? 1 : 0.5)
    }
}

#Preview {
    MenuSectionView(
        categories: ["Tacos", "Burritos", "Sides"],
        items: SampleData.menuItems(forTruck: "truck-001")
    )
    .padding()
}
