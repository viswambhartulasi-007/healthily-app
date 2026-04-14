import SwiftUI

struct RootView: View {

    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {

        if authVM.isLoggedIn {

            switch authVM.currentRole {

            case .doctor:
                DoctorDashboardView()

            case .patient:
                PatientDashboardView()

            case .nurse:
                NurseDashboardView()

            default:
                RoleSelectionView()
            }

        } else {

            RoleSelectionView()
        }
    }
}
