import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var appState: AppState
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showRoleSelection = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Create Account")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Join the VanGo community")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 20)

                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Full Name")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        TextField("Your name", text: $name)
                            .textFieldStyle(.plain)
                            .textContentType(.name)
                            .padding(14)
                            .background(Color.vangoMist, in: RoundedRectangle(cornerRadius: 12))
                    }

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
                            .background(Color.vangoMist, in: RoundedRectangle(cornerRadius: 12))
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        SecureField("Create a password", text: $password)
                            .textFieldStyle(.plain)
                            .textContentType(.newPassword)
                            .padding(14)
                            .background(Color.vangoMist, in: RoundedRectangle(cornerRadius: 12))
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Confirm Password")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        SecureField("Confirm your password", text: $confirmPassword)
                            .textFieldStyle(.plain)
                            .textContentType(.newPassword)
                            .padding(14)
                            .background(Color.vangoMist, in: RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal, 24)

                Button {
                    showRoleSelection = true
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.vangoSun, in: RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal, 24)

                Text("By creating an account, you agree to our Terms of Service and Privacy Policy")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showRoleSelection) {
            RoleSelectionView()
        }
    }
}

#Preview {
    NavigationStack {
        SignUpView()
            .environmentObject(AppState())
    }
}
