import SwiftUI

@main
struct GymBuddyAppApp: App {
    @StateObject private var auth = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            AuthGateView()
                .environmentObject(auth)
        }
    }
}
