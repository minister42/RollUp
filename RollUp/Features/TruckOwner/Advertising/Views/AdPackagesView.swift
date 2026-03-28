import SwiftUI

struct AdPackagesView: View {
    @State private var showPurchase: AdPackageTemplate?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Active Ads
                let activeAds = SampleData.adPackages.filter(\.isActive)
                if !activeAds.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("ACTIVE CAMPAIGNS")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)

                        ForEach(activeAds) { ad in
                            ActiveAdCard(ad: ad)
                        }
                    }
                }

                // Available Packages
                VStack(alignment: .leading, spacing: 10) {
                    Text("BOOST YOUR VISIBILITY")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)

                    ForEach(AdPackageTemplate.allCases) { template in
                        AdPackageCard(template: template) {
                            showPurchase = template
                        }
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("Advertise")
        .navigationBarTitleDisplayMode(.large)
        .sheet(item: $showPurchase) { template in
            AdPurchaseSheet(template: template)
        }
    }
}

struct ActiveAdCard: View {
    let ad: AdPackage

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label(ad.name, systemImage: "megaphone.fill")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Spacer()

                Text("ACTIVE")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.rollUpGreen)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.rollUpGreen.opacity(0.12), in: Capsule())
            }

            if let start = ad.startDate, let end = ad.endDate {
                Text("\(start.formatted(.dateTime.month().day())) - \(end.formatted(.dateTime.month().day()))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // Impressions progress
            HStack {
                Text("Impressions")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(Int.random(in: 1000...ad.impressionsIncluded)) / \(ad.impressionsIncluded)")
                    .font(.caption)
                    .fontWeight(.medium)
            }
        }
        .padding(14)
        .cardStyle()
    }
}

struct AdPackageCard: View {
    let template: AdPackageTemplate
    let onPurchase: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: template.icon)
                    .font(.title3)
                    .foregroundStyle(.rollUpOrange)
                    .frame(width: 40, height: 40)
                    .background(Color.rollUpOrange.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))

                VStack(alignment: .leading, spacing: 2) {
                    Text(template.rawValue)
                        .font(.headline)
                    Text(String(format: "$%.2f", template.price))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.rollUpOrange)
                }

                Spacer()

                Text("\(template.durationDays) days")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.rollUpLightGray, in: Capsule())
            }

            Text(template.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Label("\(template.impressions / 1000)K impressions", systemImage: "eye.fill")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                Button(action: onPurchase) {
                    Text("Get Started")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.rollUpOrange, in: RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding(14)
        .cardStyle()
    }
}

struct AdPurchaseSheet: View {
    let template: AdPackageTemplate
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: template.icon)
                    .font(.system(size: 56))
                    .foregroundStyle(.rollUpOrange)

                Text(template.rawValue)
                    .font(.title)
                    .fontWeight(.bold)

                Text(template.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                VStack(spacing: 8) {
                    DetailRow(label: "Duration", value: "\(template.durationDays) days")
                    DetailRow(label: "Impressions", value: "\(template.impressions / 1000)K")
                    DetailRow(label: "Price", value: String(format: "$%.2f", template.price))
                }
                .padding(16)
                .background(Color.rollUpLightGray, in: RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal, 24)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("Purchase for \(String(format: "$%.2f", template.price))")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.rollUpOrange, in: RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
            .navigationTitle("Purchase Ad")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(.rollUpOrange)
                }
            }
        }
    }
}

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    NavigationStack {
        AdPackagesView()
    }
}
