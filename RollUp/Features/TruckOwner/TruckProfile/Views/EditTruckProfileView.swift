import SwiftUI

struct EditTruckProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = "Taco Libre"
    @State private var description = "Authentic street tacos made with love."
    @State private var selectedCuisine: CuisineType = .mexican
    @State private var phone = "(512) 555-0142"
    @State private var website = "https://tacolibre.com"
    @State private var instagram = "tacolibre"
    @State private var twitter = "tacolibre"

    var body: some View {
        Form {
            Section("Basic Info") {
                TextField("Truck Name", text: $name)

                Picker("Cuisine", selection: $selectedCuisine) {
                    ForEach(CuisineType.allCases) { cuisine in
                        Text("\(cuisine.icon) \(cuisine.rawValue)")
                            .tag(cuisine)
                    }
                }

                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    TextEditor(text: $description)
                        .frame(minHeight: 80)
                }
            }

            Section("Contact") {
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundStyle(.green)
                        .frame(width: 24)
                    TextField("Phone Number", text: $phone)
                }
                HStack {
                    Image(systemName: "globe")
                        .foregroundStyle(.rollUpOrange)
                        .frame(width: 24)
                    TextField("Website URL", text: $website)
                        .textContentType(.URL)
                        .autocapitalization(.none)
                }
            }

            Section("Social Media") {
                HStack {
                    Image(systemName: "camera.fill")
                        .foregroundStyle(.purple)
                        .frame(width: 24)
                    TextField("Instagram username", text: $instagram)
                        .autocapitalization(.none)
                }
                HStack {
                    Image(systemName: "at")
                        .foregroundStyle(.blue)
                        .frame(width: 24)
                    TextField("Twitter username", text: $twitter)
                        .autocapitalization(.none)
                }
            }

            Section("Truck Photo") {
                Button {
                    // Photo picker
                } label: {
                    HStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.title2)
                            .foregroundStyle(.rollUpOrange)
                        VStack(alignment: .leading) {
                            Text("Change Truck Photo")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Text("Tap to upload a new photo")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
                    .foregroundStyle(.rollUpOrange)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") { dismiss() }
                    .fontWeight(.semibold)
                    .foregroundStyle(.rollUpOrange)
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditTruckProfileView()
    }
}
