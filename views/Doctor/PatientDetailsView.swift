import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct PatientDetailsView: View {
    
    var patientEmail: String
    
    @State private var nurseEmail: String = ""
    @State private var assignedMessage: String = ""
    
    private let db = Firestore.firestore()
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 25) {
                
                // PATIENT VITALS
                VitalsView(patientEmail: patientEmail)
                
                
                Divider()
                
                
                // ASSIGN NURSE SECTION
                
                VStack(spacing: 15) {
                    
                    Text("Assign Nurse")
                        .font(.headline)
                    
                    TextField("Enter Nurse Email", text: $nurseEmail)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    Button("Assign to Nurse") {
                        assignNurse()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    
                    if !assignedMessage.isEmpty {
                        Text(assignedMessage)
                            .foregroundColor(.green)
                            .font(.caption)
                    }
                }
                
            }
            .padding()
        }
        .navigationTitle("Patient Details")
    }
    
    
    // MARK: Assign Nurse
    
    func assignNurse() {
        
        guard let doctorId = Auth.auth().currentUser?.uid else { return }
        
        let cleanedNurse = nurseEmail
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        let cleanedPatient = patientEmail
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        db.collection("nurseAssignments").addDocument(data: [
            
            "doctorId": doctorId,
            "nurseEmail": cleanedNurse,
            "patientEmail": cleanedPatient,
            "timestamp": Timestamp()
            
        ]) { error in
            
            if let error = error {
                print("Assignment error:", error)
                assignedMessage = "Failed to assign nurse"
            } else {
                assignedMessage = "Nurse assigned successfully"
                nurseEmail = ""
            }
        }
    }
}

#Preview {
    PatientDetailsView(patientEmail: "patient1@healthify.com")
}
