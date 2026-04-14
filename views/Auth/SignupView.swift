import SwiftUI

struct SignupView: View {

    let role: String

    @EnvironmentObject var authVM: AuthViewModel

    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""   // NEW PHONE STATE

    var body: some View {

        ZStack {

            // Background gradient (same as Login & RoleSelection)

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

                VStack(spacing: 10) {

                    Image(systemName: iconForRole())
                        .font(.system(size: 50))
                        .foregroundColor(.blue)

                    Text("\(role.capitalized) Signup")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Create your secure account")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }


                // Signup Card

                VStack(spacing: 20) {

                    // EMAIL

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


                    // PHONE NUMBER (NEW FIELD)

                    HStack {

                        Image(systemName: "phone")
                            .foregroundColor(.gray)

                        TextField("Phone (+91xxxxxxxxxx)", text: $phone)
                            .keyboardType(.phonePad)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)


                    // PASSWORD

                    HStack {

                        Image(systemName: "lock")
                            .foregroundColor(.gray)

                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)


                    // Create Account Button

                    Button {
                        signupUser()
                    } label: {

                        Text("Create Account")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.green, .teal],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.08), radius: 10)
                )
                .padding(.horizontal)

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


    func signupUser() {

        authVM.signup(
            email: email,
            password: password,
            role: role,
            phone: phone   // PASS PHONE TO AUTHVIEWMODEL
        )
    }
}
