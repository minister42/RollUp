import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var password = ""
    @State private var showRoleSelection = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            VStack(spacing: 8) {
                Text("Welcome Back")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Sign in to your account")
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Email")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    TextField("you@example.com", text: $email)
                        .textFieldStyle(.plain)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(14)
                        .background(Color.rollUpLightGray, in: RoundedRectangle(cornerRadius: 12))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Password")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(.plain)
                        .textContentType(.password)
                        .padding(14)
                        .background(Color.rollUpLightGray, in: RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal, 24)

            Button {
                showRoleSelection = true
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.rollUpOrange, in: RoundedRectangle(cornerRadius: 14))
            }
            .padding(.horizontal, 24)

            Button {
                // Forgot password
            } label: {
                Text("Forgot Password?")
                    .font(.subheadline)
                    .foregroundStyle(Color.rollUpOrange)
            }

            Spacer()
            Spacer()
        }
        .navigationTitle("Sign In")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showRoleSelection) {
            RoleSelectionView()
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AppState())
    }
}
