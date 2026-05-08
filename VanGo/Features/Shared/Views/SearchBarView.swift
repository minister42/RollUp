import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var placeholder: String = "Search food trucks..."

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.vangoSlate)

            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.vangoSlate)
                }
            }
        }
        .padding(12)
        .background(Color.vangoMist)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    SearchBarView(text: .constant(""))
        .padding()
}
