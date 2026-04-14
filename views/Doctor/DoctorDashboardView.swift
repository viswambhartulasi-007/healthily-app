import SwiftUI
import FirebaseAuth

struct DoctorDashboardView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // Background Gradient
                
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.12),
                        Color.teal.opacity(0.12),
                        Color.white
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                
                ScrollView {
                    
                    VStack(spacing: 25) {
                        
                        // Doctor Profile Card
                        
                        if let email = Auth.auth().currentUser?.email {
                            
                            VStack(spacing: 10) {
                                
                                Image(systemName: "stethoscope")
                                    .font(.system(size: 40))
                                    .foregroundColor(.blue)
                                
                                Text("Doctor Dashboard")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text(email.lowercased())
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.08), radius: 10)
                            )
                            .padding(.horizontal)
                        }
                        
                        
                        // Dashboard Section
                        
                        VStack(spacing: 18) {
                            
                            NavigationLink {
                                PatientSearchView()
                            } label: {
                                
                                dashboardCard(
                                    icon: "magnifyingglass",
                                    title: "Search Patient",
                                    subtitle: "Find and request patient monitoring",
                                    color: .blue
                                )
                            }
                            
                            
                            NavigationLink {
                                PatientListView()
                            } label: {
                                
                                dashboardCard(
                                    icon: "person.3.fill",
                                    title: "My Patients",
                                    subtitle: "View vitals of assigned patients",
                                    color: .green
                                )
                            }
                            
                        }
                        .padding(.horizontal)
                        
                        
                        Spacer(minLength: 30)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Doctor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        authVM.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
        }
    }
}



func dashboardCard(icon: String, title: String, subtitle: String, color: Color) -> some View {
    
    HStack(spacing: 15) {
        
        ZStack {
            
            Circle()
                .fill(color.opacity(0.15))
                .frame(width: 50, height: 50)
            
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
        }
        
        
        VStack(alignment: .leading, spacing: 4) {
            
            Text(title)
                .font(.headline)
            
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.gray)
        }
        
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
