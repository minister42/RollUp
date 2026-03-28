import SwiftUI

struct ReviewsSectionView: View {
    let reviews: [Review]
    let averageRating: Double
    let reviewCount: Int
    var onWriteReview: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Reviews", icon: "star.bubble.fill")

            // Rating summary
            HStack(spacing: 12) {
                VStack(spacing: 4) {
                    Text(String(format: "%.1f", averageRating))
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                    RatingStarsView(rating: averageRating, maxRating: 5, starSize: 16)
                    Text("\(reviewCount) reviews")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(width: 100)

                Spacer()

                Button(action: onWriteReview) {
                    Label("Write a Review", systemImage: "square.and.pencil")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.rollUpOrange)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.rollUpOrange.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
                }
            }

            // Review list
            ForEach(reviews.prefix(5)) { review in
                ReviewRow(review: review)
            }

            if reviews.count > 5 {
                Button {
                    // Show all reviews
                } label: {
                    Text("See all \(reviewCount) reviews")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.rollUpOrange)
                }
            }
        }
    }
}

struct ReviewRow: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                RatingStarsView(rating: Double(review.rating), maxRating: 5, starSize: 12)

                Spacer()

                Text(review.timeAgo)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text(review.text)
                .font(.subheadline)
                .foregroundStyle(.primary)

            Text(review.authorName)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(Color.rollUpLightGray, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ReviewsSectionView(
        reviews: SampleData.reviews(forTruck: "truck-001"),
        averageRating: 4.8,
        reviewCount: 127,
        onWriteReview: {}
    )
    .padding()
}
