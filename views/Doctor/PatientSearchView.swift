import SwiftUI

struct PatientSearchView: View {
    
    @State private var patientEmail: String = ""
    
    @StateObject private var requestVM = RequestViewModel()
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            Text("Search Patient")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            
            TextField("Enter Patient Email", text: $patientEmail)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            
            Button("Send Request") {
                
                let cleanedEmail = patientEmail
                    .lowercased()
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                
                requestVM.sendRequest(patientEmail: cleanedEmail)
                
                patientEmail = ""
            }
            .buttonStyle(.borderedProminent)
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Search Patient")
    }
}

#Preview {
    PatientSearchView()
}
