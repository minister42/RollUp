import SwiftUI

struct CuisineFilterView: View {
    @Binding var selectedCuisines: Set<CuisineType>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(CuisineType.allCases) { cuisine in
                    CuisineChip(
                        cuisine: cuisine,
                        isSelected: selectedCuisines.contains(cuisine)
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if selectedCuisines.contains(cuisine) {
                                selectedCuisines.remove(cuisine)
                            } else {
                                selectedCuisines.insert(cuisine)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct CuisineChip: View {
    let cuisine: CuisineType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(cuisine.icon)
                    .font(.caption)
                Text(cuisine.rawValue)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? Color.rollUpOrange : Color.rollUpLightGray)
            )
            .foregroundStyle(isSelected ? .white : Color.rollUpCharcoal)
        }
    }
}

#Preview {
    CuisineFilterView(selectedCuisines: .constant([.mexican, .bbq]))
}
