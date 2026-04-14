import SwiftUI

struct VitalsView: View {
    
    var patientEmail: String
    
    @StateObject private var vitalVM = VitalViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // Background
                
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
                    
                    VStack(spacing: 20) {
                        
                        if let vital = vitalVM.latestVital {
                            
                            // ALERT BANNER
                            
                            if vital.alarm == 1 {
                                
                                HStack {
                                    
                                    Image(systemName: "exclamationmark.triangle.fill")
                                    
                                    Text("Abnormal vitals detected")
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                            
                            
                            VStack(spacing: 18) {
                                
                                // ❤️ HEART RATE WITH PULSE
                                
                                VStack(spacing: 10) {
                                    
                                    HStack {
                                        
                                        HeartBeatView(heartRate: vital.heartRate)
                                        
                                        Text("Heart Rate")
                                            .font(.headline)
                                        
                                        Spacer()
                                        
                                        HStack(alignment: .firstTextBaseline) {
                                            
                                            Text("\(vital.heartRate)")
                                                .font(.title2)
                                                .bold()
                                            
                                            Text("bpm")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 18)
                                            .fill(Color.white)
                                            .shadow(color: Color.black.opacity(0.08), radius: 8)
                                    )
                                    
                                    
                                    // ECG WAVE
                                    
                                    ECGWaveView()
                                        .padding(.horizontal)
                                }
                                
                                
                                vitalCard(
                                    icon: "lungs.fill",
                                    title: "Oxygen Level",
                                    value: "\(vital.oxygen)",
                                    unit: "%",
                                    color: oxygenColor(vital.oxygen)
                                )
                                
                                
                                vitalCard(
                                    icon: "thermometer",
                                    title: "Temperature",
                                    value: "\(vital.temperature)",
                                    unit: "°C",
                                    color: temperatureColor(vital.temperature)
                                )
                                
                                
                                vitalCard(
                                    icon: "waveform.path.ecg",
                                    title: "Respiration",
                                    value: "\(vital.respiration)",
                                    unit: "rpm",
                                    color: .green
                                )
                                
                                
                                vitalCard(
                                    icon: "heart.text.square.fill",
                                    title: "Blood Pressure",
                                    value: "\(vital.bloodPressure)",
                                    unit: "mmHg",
                                    color: .purple
                                )
                            }
                            .padding(.horizontal)
                            
                        } else {
                            
                            VStack(spacing: 15) {
                                
                                ProgressView()
                                
                                Text("Waiting for real-time vitals...")
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 50)
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Patient Vitals")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                vitalVM.fetchVitals(patientEmail: patientEmail)
            }
        }
    }
}



func vitalCard(icon: String, title: String, value: String, unit: String, color: Color) -> some View {
    
    HStack(spacing: 15) {
        
        ZStack {
            
            Circle()
                .fill(color.opacity(0.15))
                .frame(width: 50, height: 50)
            
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title3)
        }
        
        
        VStack(alignment: .leading, spacing: 4) {
            
            Text(title)
                .font(.headline)
            
            Text("Live monitoring")
                .font(.caption)
                .foregroundColor(.gray)
        }
        
        Spacer()
        
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(unit)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    .padding()
    .background(
        RoundedRectangle(cornerRadius: 18)
            .fill(Color.white)
            .shadow(color: Color.black.opacity(0.08), radius: 8)
    )
}



func oxygenColor(_ oxygen: Int) -> Color {
    
    if oxygen < 90 { return .red }
    if oxygen < 94 { return .orange }
    return .blue
}



func temperatureColor(_ temp: Double) -> Color {
    
    if temp > 39 { return .red }
    if temp > 37.5 { return .orange }
    return .green
}
