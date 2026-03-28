import SwiftUI

struct MenuManagementView: View {
    private let items = SampleData.menuItems(forTruck: "truck-001")
    @State private var showAddItem = false

    private var categories: [String] {
        Array(Set(items.map(\.category))).sorted()
    }

    var body: some View {
        List {
            ForEach(categories, id: \.self) { category in
                Section(category) {
                    ForEach(items.filter { $0.category == category }) { item in
                        NavigationLink {
                            MenuItemEditorView(item: item)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(item.name)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Text(item.description)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                }

                                Spacer()

                                VStack(alignment: .trailing, spacing: 3) {
                                    Text(item.priceString)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)

                                    HStack(spacing: 4) {
                                        Circle()
                                            .fill(item.isAvailable ? Color.rollUpGreen : Color.red)
                                            .frame(width: 6, height: 6)
                                        Text(item.isAvailable ? "Available" : "Sold Out")
                                            .font(.caption2)
                                            .foregroundStyle(item.isAvailable ? .rollUpGreen : .red)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Menu")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddItem = true
                } label: {
                    Image(systemName: "plus")
                        .fontWeight(.semibold)
                        .foregroundStyle(.rollUpOrange)
                }
            }
        }
        .sheet(isPresented: $showAddItem) {
            NavigationStack {
                MenuItemEditorView(item: nil)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MenuManagementView()
    }
}
