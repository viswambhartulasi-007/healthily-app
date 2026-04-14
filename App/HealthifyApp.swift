import SwiftUI
import FirebaseCore

@main
struct HealthifyApp: App {

    @StateObject var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
        }
    }
}
