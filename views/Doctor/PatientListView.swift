import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct PatientListView: View {
    
    @State private var patients: [String] = []
    
    private var db = Firestore.firestore()
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                if patients.isEmpty {
                    
                    Text("No patients yet")
                        .foregroundColor(.gray)
                        .padding()
                }
                
                List(patients, id: \.self) { patientEmail in
                    
                    NavigationLink {
                        
                        VitalsView(patientEmail: patientEmail)
                        
                    } label: {
                        
                        VStack(alignment: .leading) {
                            
                            Text(patientEmail)
                                .font(.headline)
                            
                            Text("Tap to monitor vitals")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("My Patients")
            .onAppear {
                fetchPatients()
            }
        }
    }
    
    
    func fetchPatients() {
        
        guard let doctorId = Auth.auth().currentUser?.uid else {
            print("Doctor not logged in")
            return
        }
        
        db.collection("doctorPatientMappings")
            .whereField("doctorId", isEqualTo: doctorId)
            .addSnapshotListener { snapshot, error in
                
                if let error = error {
                    print("Fetch error:", error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                DispatchQueue.main.async {
                    
                    self.patients = documents.compactMap {
                        $0.data()["patientEmail"] as? String
                    }
                }
            }
    }
}

#Preview {
    PatientListView()
}
