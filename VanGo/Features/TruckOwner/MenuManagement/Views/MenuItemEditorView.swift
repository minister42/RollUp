import SwiftUI

struct MenuItemEditorView: View {
    let item: MenuItem?
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var category: String = ""
    @State private var isAvailable: Bool = true

    private var isEditing: Bool { item != nil }

    var body: some View {
        Form {
            Section("Item Details") {
                TextField("Item Name", text: $name)
                TextField("Description", text: $description)
                TextField("Category (e.g. Tacos, Sides)", text: $category)
            }

            Section("Pricing") {
                HStack {
                    Text("$")
                        .foregroundStyle(.secondary)
                    TextField("0.00", text: $price)
                        .keyboardType(.decimalPad)
                }
            }

            Section("Availability") {
                Toggle("Available", isOn: $isAvailable)
                    .tint(.vangoOlive)
            }

            Section("Photo") {
                Button {
                    // Photo picker
                } label: {
                    HStack {
                        Image(systemName: "camera.fill")
                            .foregroundStyle(.vangoSun)
                        Text("Add Photo")
                            .foregroundStyle(.vangoSun)
                    }
                }
            }

            if isEditing {
                Section {
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Item")
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationTitle(isEditing ? "Edit Item" : "Add Item")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
                    .foregroundStyle(.vangoSun)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") { dismiss() }
                    .fontWeight(.semibold)
                    .foregroundStyle(.vangoSun)
            }
        }
        .onAppear {
            if let item {
                name = item.name
                description = item.description
                price = String(format: "%.2f", item.price)
                category = item.category
                isAvailable = item.isAvailable
            }
        }
    }
}

#Preview("Add") {
    NavigationStack {
        MenuItemEditorView(item: nil)
    }
}

#Preview("Edit") {
    NavigationStack {
        MenuItemEditorView(item: SampleData.menuItems[0])
    }
}
