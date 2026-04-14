import Foundation
import FirebaseFirestore

struct Vital: Identifiable {
    
    var id: String
    var patientEmail: String
    var heartRate: Int
    var oxygen: Int
    var temperature: Double
    var respiration: Int
    var bloodPressure: Int
    var alarm: Int
    var timestamp: Timestamp?
    
}
