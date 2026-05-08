import SwiftUI

struct WriteReviewView: View {
    let truckName: String
    @Environment(\.dismiss) private var dismiss
    @State private var rating = 0
    @State private var reviewText = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Rate \(truckName)")
                        .font(.title3)
                        .fontWeight(.bold)

                    InteractiveRatingView(rating: $rating)
                }
                .padding(.top, 20)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Your Review")
                        .font(.subheadline)
                        .fontWeight(.medium)

                    TextEditor(text: $reviewText)
                        .frame(minHeight: 120)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.vangoMist, lineWidth: 2)
                        )
                        .overlay(alignment: .topLeading) {
                            if reviewText.isEmpty {
                                Text("Tell others about your experience...")
                                    .foregroundStyle(.tertiary)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 16)
                                    .allowsHitTesting(false)
                            }
                        }
                }
                .padding(.horizontal, 24)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("Submit Review")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            (rating > 0 && !reviewText.isEmpty) ? Color.vangoSun : Color.vangoSlate,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                }
                .disabled(rating == 0 || reviewText.isEmpty)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
            .navigationTitle("Write Review")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(.vangoSun)
                }
            }
        }
    }
}

#Preview {
    WriteReviewView(truckName: "Taco Libre")
}
