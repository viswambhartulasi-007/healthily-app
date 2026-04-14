import SwiftUI

struct HeartBeatView: View {
    
    var heartRate: Int
    
    @State private var beat = false
    
    var body: some View {
        
        Image(systemName: "heart.fill")
            .foregroundColor(.red)
            .font(.system(size: 28))
            .scaleEffect(beat ? 1.2 : 0.8)
            .animation(
                .easeInOut(duration: animationSpeed())
                .repeatForever(autoreverses: true),
                value: beat
            )
            .onAppear {
                beat = true
            }
    }
    
    
    func animationSpeed() -> Double {
        
        // faster heart rate = faster animation
        
        if heartRate > 120 { return 0.25 }
        if heartRate > 100 { return 0.35 }
        if heartRate > 80 { return 0.45 }
        return 0.6
    }
}
