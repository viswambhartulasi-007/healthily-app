import SwiftUI

struct SplashView: View {
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            
            Text("Healthify")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Remote Patient Monitoring")
                .foregroundColor(.gray)
            
        }
    }
}

#Preview {
    SplashView()
}
