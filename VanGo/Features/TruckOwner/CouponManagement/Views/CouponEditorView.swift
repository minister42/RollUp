import SwiftUI

struct CouponEditorView: View {
    let coupon: Coupon?
    @Environment(\.dismiss) private var dismiss

    @State private var code = ""
    @State private var description = ""
    @State private var discountType: DiscountType = .percentage
    @State private var discountValue = ""
    @State private var maxRedemptions = ""
    @State private var expiresAt = Date().addingTimeInterval(86400 * 30)
    @State private var isActive = true

    private var isEditing: Bool { coupon != nil }

    var body: some View {
        Form {
            Section("Coupon Details") {
                TextField("Coupon Code (e.g. TACO10)", text: $code)
                    .autocapitalization(.allCharacters)
                TextField("Description", text: $description)
            }

            Section("Discount") {
                Picker("Type", selection: $discountType) {
                    ForEach(DiscountType.allCases, id: \.self) { type in
                        Text(type.displayName).tag(type)
                    }
                }

                HStack {
                    Text(discountType == .percentage ? "%" : "$")
                        .foregroundStyle(.secondary)
                    TextField("Value", text: $discountValue)
                        .keyboardType(.decimalPad)
                }
            }

            Section("Limits") {
                TextField("Max Redemptions (optional)", text: $maxRedemptions)
                    .keyboardType(.numberPad)

                DatePicker("Expires", selection: $expiresAt, displayedComponents: .date)

                Toggle("Active", isOn: $isActive)
                    .tint(.vangoOlive)
            }

            Section("Revenue Share") {
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                    Text("\(Int(AppConstants.defaultRevenueSharePercent))% of each redemption value goes to VanGo")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            if isEditing {
                Section {
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Coupon")
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationTitle(isEditing ? "Edit Coupon" : "New Coupon")
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
            if let coupon {
                code = coupon.code
                description = coupon.description
                discountType = coupon.discountType
                discountValue = String(Int(coupon.discountValue))
                maxRedemptions = coupon.maxRedemptions.map { String($0) } ?? ""
                expiresAt = coupon.expiresAt
                isActive = coupon.isActive
            }
        }
    }
}

#Preview("Create") {
    NavigationStack {
        CouponEditorView(coupon: nil)
    }
}

#Preview("Edit") {
    NavigationStack {
        CouponEditorView(coupon: SampleData.coupons[0])
    }
}
