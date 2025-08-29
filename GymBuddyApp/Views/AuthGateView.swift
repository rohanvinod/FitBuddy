import SwiftUI

struct AuthGateView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var isCheckingCredentials = true

    var body: some View {
        NavigationStack {
            Group {
                if isCheckingCredentials {
                    // Enhanced loading state
                    ZStack {
                        // Background gradient
                        LinearGradient(
                            gradient: Gradient(colors: [Color.coffeeGradientStart, Color.coffeeGradientEnd]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea()
                        
                        VStack(spacing: 30) {
                            // App logo/icon
                            ZStack {
                                Circle()
                                    .fill(Color.coffeeCard.opacity(0.1))
                                    .frame(width: 120, height: 120)
                                
                                Image(systemName: "figure.strengthtraining.traditional")
                                    .font(.system(size: 60))
                                    .foregroundColor(.coffeeCard)
                            }
                            
                            VStack(spacing: 16) {
                                Text("GymBuddy")
                                    .font(.system(size: 36, weight: .bold, design: .rounded))
                                    .foregroundColor(.coffeeCard)
                                
                                Text("Finding your perfect gym partner...")
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                                    .foregroundColor(.coffeeCard.opacity(0.8))
                                    .multilineTextAlignment(.center)
                            }
                            
                            // Loading indicator
                            VStack(spacing: 20) {
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .coffeeCard))
                                
                                Text("Checking credentials...")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.coffeeCard.opacity(0.7))
                            }
                        }
                    }
                    .onAppear {
                        // Give a brief moment for auto-login to complete
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isCheckingCredentials = false
                            }
                        }
                    }
                } else if auth.isAuthenticated {
                    ContentView()
                } else {
                    LoginView()
                }
            }
        }
    }
} 