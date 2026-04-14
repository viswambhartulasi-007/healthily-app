import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct NurseDashboardView: View {

    @EnvironmentObject var authVM: AuthViewModel

    @State private var assignedPatients: [String] = []

    private let db = Firestore.firestore()

    var body: some View {

        NavigationStack {

            ZStack {

                // Background Gradient

                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.12),
                        Color.teal.opacity(0.12),
                        Color.white
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()


                ScrollView {

                    VStack(spacing: 25) {

                        // Nurse Profile Card

                        if let email = Auth.auth().currentUser?.email {

                            VStack(spacing: 10) {

                                Image(systemName: "cross.case.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.green)

                                Text("Nurse Dashboard")
                                    .font(.title)
                                    .fontWeight(.bold)

                                Text(email.lowercased())
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.08), radius: 10)
                            )
                            .padding(.horizontal)
                        }


                        // Assigned Patients Section

                        if assignedPatients.isEmpty {

                            VStack(spacing: 10) {

                                Image(systemName: "person.slash")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)

                                Text("No patients assigned")
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 40)

                        } else {

                            VStack(spacing: 18) {

                                ForEach(assignedPatients, id: \.self) { email in

                                    NavigationLink {

                                        NursePatientView(
                                            patientEmail: email
                                                .lowercased()
                                                .trimmingCharacters(in: .whitespacesAndNewlines)
                                        )

                                    } label: {

                                        nursePatientCard(email: email)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        Spacer(minLength: 30)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Assigned Patients")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .navigationBarTrailing) {

                    Button {
                        authVM.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
        }
        .onAppear {
            fetchAssignments()
        }
    }



    func fetchAssignments() {

        guard let nurseEmail = Auth.auth().currentUser?.email?
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines) else { return }

        db.collection("nurseAssignments")
            .whereField("nurseEmail", isEqualTo: nurseEmail)
            .addSnapshotListener { snapshot, error in

                if let error = error {
                    print("Error fetching assignments:", error)
                    return
                }

                guard let docs = snapshot?.documents else { return }

                var patients: [String] = []

                for doc in docs {

                    if let email = doc.data()["patientEmail"] as? String {

                        let cleanedEmail = email
                            .lowercased()
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        patients.append(cleanedEmail)
                    }
                }

                assignedPatients = Array(Set(patients)).sorted()
            }
    }
}



func nursePatientCard(email: String) -> some View {

    HStack(spacing: 15) {

        ZStack {

            Circle()
                .fill(Color.green.opacity(0.15))
                .frame(width: 50, height: 50)

            Image(systemName: "person.fill")
                .foregroundColor(.green)
        }


        VStack(alignment: .leading, spacing: 4) {

            Text(email)
                .font(.headline)

            Text("Tap to monitor vitals")
                .font(.caption)
                .foregroundColor(.gray)
        }

        Spacer()

        Image(systemName: "chevron.right")
            .foregroundColor(.gray)
    }
    .padding()
    .background(
        RoundedRectangle(cornerRadius: 18)
            .fill(Color.white)
            .shadow(color: Color.black.opacity(0.08), radius: 8)
    )
}
