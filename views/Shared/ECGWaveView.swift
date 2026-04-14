import SwiftUI

struct ECGWaveView: View {

    @State private var animate = false

    var body: some View {

        GeometryReader { geo in

            Path { path in

                let width = geo.size.width
                let height = geo.size.height
                let mid = height / 2

                path.move(to: CGPoint(x: 0, y: mid))

                path.addLine(to: CGPoint(x: width * 0.15, y: mid))
                path.addLine(to: CGPoint(x: width * 0.20, y: mid - 20))
                path.addLine(to: CGPoint(x: width * 0.25, y: mid + 20))
                path.addLine(to: CGPoint(x: width * 0.30, y: mid))
                path.addLine(to: CGPoint(x: width * 0.45, y: mid))
                path.addLine(to: CGPoint(x: width * 0.50, y: mid - 30))
                path.addLine(to: CGPoint(x: width * 0.55, y: mid + 30))
                path.addLine(to: CGPoint(x: width * 0.60, y: mid))
                path.addLine(to: CGPoint(x: width * 0.75, y: mid))
                path.addLine(to: CGPoint(x: width, y: mid))
            }
            .stroke(Color.green, lineWidth: 2)
            .offset(x: animate ? -geo.size.width : geo.size.width)
            .animation(
                .linear(duration: 2)
                .repeatForever(autoreverses: false),
                value: animate
            )
        }
        .frame(height: 40)
        .onAppear {
            animate = true
        }
    }
}
