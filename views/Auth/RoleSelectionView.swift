import SwiftUI

struct RoleSelectionView: View {
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // Background Medical Gradient
                
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.15),
                        Color.teal.opacity(0.15),
                        Color.white
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                
                VStack(spacing: 40) {
                    
                    Spacer()
                    
                    // App Logo Area
                    
                    VStack(spacing: 10) {
                        
                        Image(systemName: "cross.case.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.blue)
                        
                        Text("Healthify")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Smart Patient Monitoring")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    
                    // Role Buttons
                    
                    VStack(spacing: 20) {
                        
                        NavigationLink(destination: LoginView(role: "doctor")) {
                            roleCard(
                                icon: "stethoscope",
                                title: "Doctor",
                                color: .blue
                            )
                        }
                        
                        NavigationLink(destination: LoginView(role: "nurse")) {
                            roleCard(
                                icon: "cross.case",
                                title: "Nurse",
                                color: .green
                            )
                        }
                        
                        NavigationLink(destination: LoginView(role: "patient")) {
                            roleCard(
                                icon: "heart.text.square",
                                title: "Patient",
                                color: .orange
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


func roleCard(icon: String, title: String, color: Color) -> some View {
    
    HStack(spacing: 20) {
        
        Image(systemName: icon)
            .font(.title2)
            .foregroundColor(color)
            .frame(width: 35)
        
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
        
        Spacer()
        
        Image(systemName: "chevron.right")
            .foregroundColor(.gray)
    }
    .padding()
    .background(
        RoundedRectangle(cornerRadius: 18)
            .fill(Color.white)
            .shadow(color: Color.black.opacity(0.08), radius: 8)
    )
}
