import SwiftUI
import Charts

struct VitalChartView: View {
    
    var vitals: [Vital]
    
    var body: some View {
        
        Chart {
            
            ForEach(vitals) { vital in
                
                LineMark(
                    x: .value("Index", vital.id),
                    y: .value("Heart Rate", vital.heartRate)
                )
                .foregroundStyle(.red)
                
                
                LineMark(
                    x: .value("Index", vital.id),
                    y: .value("Oxygen", vital.oxygen)
                )
                .foregroundStyle(.blue)
            }
        }
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    VitalChartView(vitals: [])
}
