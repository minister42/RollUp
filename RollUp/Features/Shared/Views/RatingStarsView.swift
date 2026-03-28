import SwiftUI

struct RatingStarsView: View {
    let rating: Double
    let maxRating: Int
    var starSize: CGFloat = 14
    var color: Color = .yellow

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: starImageName(for: index))
                    .font(.system(size: starSize))
                    .foregroundStyle(index <= Int(rating.rounded()) ? color : Color.gray.opacity(0.3))
            }
        }
    }

    private func starImageName(for index: Int) -> String {
        let value = Double(index)
        if value <= rating {
            return "star.fill"
        } else if value - 0.5 <= rating {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}

/// Interactive star rating for writing reviews
struct InteractiveRatingView: View {
    @Binding var rating: Int
    var starSize: CGFloat = 32

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .font(.system(size: starSize))
                    .foregroundStyle(index <= rating ? Color.yellow : Color.gray.opacity(0.3))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            rating = index
                        }
                    }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        RatingStarsView(rating: 4.5, maxRating: 5)
        RatingStarsView(rating: 3.0, maxRating: 5, starSize: 20)
        InteractiveRatingView(rating: .constant(3))
    }
}
