import SwiftUI

struct NursePatientView: View {
    
    var patientEmail: String
    
    var body: some View {
        
        VitalsView(patientEmail: patientEmail.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
            .navigationTitle("Patient Monitor")
        
    }
}

#Preview {
    NursePatientView(patientEmail: "patient1@healthify.com")
}
