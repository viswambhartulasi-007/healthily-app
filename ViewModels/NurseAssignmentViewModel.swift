import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class NurseAssignmentViewModel: ObservableObject {
    
    @Published var assignments: [NurseAssignment] = []
    
    private var db = Firestore.firestore()
    
    
    func assignNurse(nurseEmail: String, patientEmail: String) {
        
        guard let doctorId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("nurseAssignments").addDocument(data: [
            "doctorId": doctorId,
            "nurseEmail": nurseEmail.lowercased(),
            "patientEmail": patientEmail.lowercased(),
            "timestamp": Timestamp()
        ]) { error in
            
            if let error = error {
                print("Assignment error:", error.localizedDescription)
            } else {
                print("Nurse assigned successfully")
            }
        }
    }
    
    
    func fetchAssignments(nurseEmail: String) {
        
        db.collection("nurseAssignments")
            .whereField("nurseEmail", isEqualTo: nurseEmail.lowercased())
            .addSnapshotListener { snapshot, error in
                
                if let error = error {
                    print("Fetch error:", error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                DispatchQueue.main.async {
                    
                    self.assignments = documents.map { doc in
                        
                        let data = doc.data()
                        
                        return NurseAssignment(
                            id: doc.documentID,
                            doctorId: data["doctorId"] as? String ?? "",
                            nurseEmail: data["nurseEmail"] as? String ?? "",
                            patientEmail: data["patientEmail"] as? String ?? ""
                        )
                    }
                }
            }
    }
}
