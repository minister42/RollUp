import SwiftUI

struct AuthGateView: View {
    @State private var showLogin = false
    @State private var showSignUp = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                // Logo & Branding
                VStack(spacing: 12) {
                    Image(systemName: "truck.box.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(Color.rollUpOrange)

                    Text("RollUp")
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.rollUpCharcoal)

                    Text("Find food trucks near you")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                // Buttons
                VStack(spacing: 14) {
                    Button {
                        showSignUp = true
                    } label: {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.rollUpOrange, in: RoundedRectangle(cornerRadius: 14))
                    }

                    Button {
                        showLogin = true
                    } label: {
                        Text("I already have an account")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.rollUpOrange)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .background(Color.rollUpCream.ignoresSafeArea())
            .navigationDestination(isPresented: $showLogin) {
                LoginView()
            }
            .navigationDestination(isPresented: $showSignUp) {
                SignUpView()
            }
        }
    }
}

#Preview {
    AuthGateView()
        .environmentObject(AppState())
}
