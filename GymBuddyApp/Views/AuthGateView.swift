import SwiftUI

struct AuthGateView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        NavigationStack {
            Group {
                if auth.isAuthenticated {
                    ContentView()
                } else {
                    LoginView()
                }
            }
        }
    }
} 