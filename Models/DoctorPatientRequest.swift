import Foundation

struct DoctorPatientRequest: Identifiable {
    
    var id: String
    var doctorId: String
    var doctorEmail: String
    var patientEmail: String
    var status: String
}
