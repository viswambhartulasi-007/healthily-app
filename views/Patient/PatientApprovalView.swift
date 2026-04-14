import SwiftUI
import FirebaseFirestore

struct PatientApprovalView: View {
    
    var patientEmail: String
    
    @StateObject var requestVM = RequestViewModel()
    
    var body: some View {
        
        List(requestVM.requests) { request in
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Doctor: \(request.doctorEmail)")
                    .font(.headline)
                
                Text("Status: \(request.status)")
                    .foregroundColor(.gray)
                
                
                if request.status == "pending" {
                    
                    HStack {
                        
                        Button("Accept") {
                            requestVM.approveRequest(requestId: request.id)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        
                        Button("Reject") {
                            requestVM.rejectRequest(requestId: request.id)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                if request.status == "approved" {
                    
                    Button("Stop Sharing") {
                        requestVM.rejectRequest(requestId: request.id)
                    }
                    .foregroundColor(.red)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Doctor Requests")
        .onAppear {
            requestVM.fetchRequests(patientEmail: patientEmail)
        }
    }
}

#Preview {
    PatientApprovalView(patientEmail: "test@email.com")
}
