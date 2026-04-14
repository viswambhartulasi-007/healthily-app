import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class RequestViewModel: ObservableObject {
    
    @Published var requests: [DoctorPatientRequest] = []
    
    private var db = Firestore.firestore()
    
    
    // SEND REQUEST
    func sendRequest(patientEmail: String) {
        
        guard let doctor = Auth.auth().currentUser else {
            print("Doctor not logged in")
            return
        }
        
        let doctorId = doctor.uid
        let doctorEmail = doctor.email ?? ""
        
        db.collection("doctorRequests").addDocument(data: [
            
            "doctorId": doctorId,
            "doctorEmail": doctorEmail,
            "patientEmail": patientEmail.lowercased(),
            "status": "pending",
            "timestamp": Timestamp()
            
        ]) { error in
            
            if let error = error {
                print("Request error:", error.localizedDescription)
            } else {
                print("Request sent successfully")
            }
        }
    }
    
    
    // FETCH REQUESTS FOR PATIENT
    func fetchRequests(patientEmail: String) {
        
        db.collection("doctorRequests")
            .whereField("patientEmail", isEqualTo: patientEmail.lowercased())
            .addSnapshotListener { snapshot, error in
                
                if let error = error {
                    print("Fetch error:", error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                DispatchQueue.main.async {
                    
                    self.requests = documents.map { doc in
                        
                        let data = doc.data()
                        
                        return DoctorPatientRequest(
                            id: doc.documentID,
                            doctorId: data["doctorId"] as? String ?? "",
                            doctorEmail: data["doctorEmail"] as? String ?? "",
                            patientEmail: data["patientEmail"] as? String ?? "",
                            status: data["status"] as? String ?? ""
                        )
                    }
                }
            }
    }
    
    
    // APPROVE REQUEST
    func approveRequest(requestId: String) {
        
        let requestRef = db.collection("doctorRequests").document(requestId)
        
        requestRef.getDocument { snapshot, error in
            
            guard let data = snapshot?.data() else { return }
            
            let doctorId = data["doctorId"] as? String ?? ""
            let patientEmail = data["patientEmail"] as? String ?? ""
            
            
            requestRef.updateData([
                "status": "approved"
            ])
            
            
            self.db.collection("doctorPatientMappings")
                .addDocument(data: [
                    "doctorId": doctorId,
                    "patientEmail": patientEmail,
                    "timestamp": Timestamp()
                ])
        }
    }
    
    
    // REJECT REQUEST
    func rejectRequest(requestId: String) {
        
        db.collection("doctorRequests")
            .document(requestId)
            .updateData([
                "status": "rejected"
            ])
    }
}
