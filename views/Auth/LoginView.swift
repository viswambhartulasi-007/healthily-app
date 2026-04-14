import SwiftUI

struct LoginView: View {

    let role: String

    @EnvironmentObject var authVM: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    var body: some View {

        ZStack {

            // Background Gradient (same theme as RoleSelection)

            LinearGradient(
                colors: [
                    Color.blue.opacity(0.15),
                    Color.teal.opacity(0.15),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            
            VStack(spacing: 35) {

                Spacer()

                // Header

                VStack(spacing: 8) {

                    Image(systemName: iconForRole())
                        .font(.system(size: 50))
                        .foregroundColor(.blue)

                    Text("\(role.capitalized) Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Access your dashboard securely")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }


                // Login Card

                VStack(spacing: 20) {

                    HStack {

                        Image(systemName: "envelope")
                            .foregroundColor(.gray)

                        TextField("Email", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)


                    HStack {

                        Image(systemName: "lock")
                            .foregroundColor(.gray)

                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)


                    // Login Button

                    Button {
                        loginUser()
                    } label: {

                        Text("Login")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.blue, .teal],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }


                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.08), radius: 10)
                )
                .padding(.horizontal)


                // Signup Navigation

                NavigationLink(destination: SignupView(role: role)) {

                    Text("Create New Account")
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                }

                Spacer()

            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }



    func iconForRole() -> String {

        switch role {
        case "doctor":
            return "stethoscope"
        case "nurse":
            return "cross.case"
        default:
            return "heart.text.square"
        }
    }



    func loginUser() {

        let cleanedEmail = email
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanedEmail.isEmpty, !password.isEmpty else {
            errorMessage = "Enter email and password"
            return
        }

        authVM.login(email: cleanedEmail, password: password)
    }
}
