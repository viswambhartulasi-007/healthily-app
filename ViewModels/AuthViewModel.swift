import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var currentRole: UserRole? = nil

    private let db = Firestore.firestore()

    // DO NOT AUTO LOGIN
    init() {}

    
    // LOGIN

    func login(email: String, password: String) {

        let cleanedEmail = email
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        Auth.auth().signIn(withEmail: cleanedEmail, password: password) { result, error in

            if let error = error {
                print("Login error:", error.localizedDescription)
                return
            }

            guard let email = result?.user.email else { return }

            self.fetchUserRole(email: email)
        }
    }


    // SIGNUP (UPDATED WITH PHONE)

    func signup(email: String, password: String, role: String, phone: String) {

        let cleanedEmail = email
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let cleanedPhone = phone
            .trimmingCharacters(in: .whitespacesAndNewlines)

        Auth.auth().createUser(withEmail: cleanedEmail, password: password) { result, error in

            if let error = error {
                print("Signup error:", error.localizedDescription)
                return
            }

            guard let user = result?.user else { return }

            self.db.collection("users").document(user.uid).setData([
                "email": cleanedEmail,
                "role": role,
                "phone": cleanedPhone
            ])

            DispatchQueue.main.async {
                self.currentRole = UserRole(rawValue: role)
                self.isLoggedIn = true
            }
        }
    }


    // FETCH ROLE

    func fetchUserRole(email: String) {

        db.collection("users")
            .whereField("email", isEqualTo: email.lowercased())
            .getDocuments { snapshot, error in

                if let doc = snapshot?.documents.first {

                    let roleString = doc.data()["role"] as? String ?? ""

                    DispatchQueue.main.async {
                        self.currentRole = UserRole(rawValue: roleString)
                        self.isLoggedIn = true
                    }
                }
            }
    }


    // LOGOUT

    func logout() {

        try? Auth.auth().signOut()

        DispatchQueue.main.async {
            self.isLoggedIn = false
            self.currentRole = nil
        }
    }
}
