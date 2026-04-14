import Foundation
import FirebaseFirestore
import Combine

class VitalViewModel: ObservableObject {

    @Published var latestVital: Vital?

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?


    func fetchVitals(patientEmail: String) {

        let cleanedEmail = patientEmail
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        // remove old listener if any
        listener?.remove()

        listener = db.collection("vitals")
            .whereField("patientEmail", isEqualTo: cleanedEmail)
            .addSnapshotListener { snapshot, error in

                guard let docs = snapshot?.documents else { return }

                // get the newest document manually
                let sortedDocs = docs.sorted {

                    let t1 = ($0.data()["timestamp"] as? Timestamp)?.dateValue() ?? Date.distantPast
                    let t2 = ($1.data()["timestamp"] as? Timestamp)?.dateValue() ?? Date.distantPast

                    return t1 > t2
                }

                guard let doc = sortedDocs.first else { return }

                let data = doc.data()

                DispatchQueue.main.async {

                    self.latestVital = Vital(
                        id: doc.documentID,
                        patientEmail: data["patientEmail"] as? String ?? "",
                        heartRate: data["heartRate"] as? Int ?? 0,
                        oxygen: data["oxygen"] as? Int ?? 0,
                        temperature: data["temperature"] as? Double ?? 0,
                        respiration: data["respiration"] as? Int ?? 0,
                        bloodPressure: data["bloodPressure"] as? Int ?? 0,
                        alarm: data["alarm"] as? Int ?? 0,
                        timestamp: data["timestamp"] as? Timestamp
                    )
                }
            }
    }


    deinit {
        listener?.remove()
    }
}
