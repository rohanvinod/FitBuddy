import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var showPassword: Bool = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.coffeeGradientStart, Color.coffeeGradientEnd]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header section with image
                    VStack(spacing: 20) {
                        // Decorative image placeholder
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.coffeeCard.opacity(0.1))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "figure.strengthtraining.traditional")
                                .font(.system(size: 50))
                                .foregroundColor(.coffeeCard)
                        }
                        .padding(.top, 40)
                        
                        VStack(spacing: 8) {
                            Text("Welcome Back")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.coffeeCard)
                            
                            Text("Sign in to continue your fitness journey")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeCard.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.bottom, 40)
                    
                    // Login form card
                    VStack(spacing: 0) {
                        VStack(spacing: 24) {
                            // Email field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.coffeeText)
                                
                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(.coffeePrimary)
                                        .frame(width: 20)
                                    
                                    TextField("Enter your email", text: $auth.loginEmail)
                                        .textContentType(.emailAddress)
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .font(.system(size: 16, design: .rounded))
                                        .foregroundColor(.coffeeText)
                                }
                                .padding()
                                .background(Color.coffeeBackground)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
                                )
                            }
                            
                            // Username field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Username")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.coffeeText)
                                
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.coffeePrimary)
                                        .frame(width: 20)
                                    
                                    TextField("Enter your username", text: $auth.loginUsername)
                                        .textContentType(.username)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .font(.system(size: 16, design: .rounded))
                                        .foregroundColor(.coffeeText)
                                }
                                .padding()
                                .background(Color.coffeeBackground)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
                                )
                            }
                            
                            // Password field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.coffeeText)
                                
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(.coffeePrimary)
                                        .frame(width: 20)
                                    
                                    if showPassword {
                                        TextField("Enter your password", text: $auth.loginPassword)
                                            .textContentType(.password)
                                            .font(.system(size: 16, design: .rounded))
                                            .foregroundColor(.coffeeText)
                                    } else {
                                        SecureField("Enter your password", text: $auth.loginPassword)
                                            .textContentType(.password)
                                            .font(.system(size: 16, design: .rounded))
                                            .foregroundColor(.coffeeText)
                                    }
                                    
                                    Button(action: { showPassword.toggle() }) {
                                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(.coffeePrimary)
                                            .font(.system(size: 16))
                                    }
                                }
                                .padding()
                                .background(Color.coffeeBackground)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
                                )
                            }
                            
                            // Remember Me toggle
                            HStack {
                                Toggle(isOn: $auth.rememberMe) {
                                    Text("Remember Me")
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.coffeeTextSecondary)
                                }
                                .toggleStyle(SwitchToggleStyle(tint: .coffeePrimary))
                                
                                Spacer()
                                
                                Button("Forgot Password?") {
                                    // Handle forgot password
                                }
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeePrimary)
                            }
                            
                            // Error message
                            if let error = auth.loginError {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.coffeeError)
                                    Text(error)
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.coffeeError)
                                }
                                .padding()
                                .background(Color.coffeeError.opacity(0.1))
                                .cornerRadius(12)
                            }
                            
                            // Login button
                            Button(action: { auth.login() }) {
                                HStack {
                                    Text("Sign In")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(.coffeeCard)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(
                                    AnyShapeStyle(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.coffeePrimary, Color.coffeeSecondary]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(color: Color.coffeeShadowStrong, radius: 8, x: 0, y: 4)
                            }
                            .disabled(auth.loginUsername.trimmingCharacters(in: .whitespaces).isEmpty || auth.loginPassword.isEmpty)
                            .opacity(auth.loginUsername.trimmingCharacters(in: .whitespaces).isEmpty || auth.loginPassword.isEmpty ? 0.6 : 1)
                            
                            // Divider
                            HStack {
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.coffeeTextLight.opacity(0.3))
                                Text("or")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.coffeeTextLight)
                                    .padding(.horizontal, 16)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.coffeeTextLight.opacity(0.3))
                            }
                            .padding(.vertical, 8)
                            
                            // Social login buttons
                            VStack(spacing: 12) {
                                Button(action: {}) {
                                    HStack {
                                        Image(systemName: "apple.logo")
                                            .font(.system(size: 18))
                                        Text("Continue with Apple")
                                            .font(.system(size: 16, weight: .medium, design: .rounded))
                                    }
                                    .foregroundColor(.coffeeCard)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.black)
                                    .cornerRadius(16)
                                }
                                
                                Button(action: {}) {
                                    HStack {
                                        Image(systemName: "globe")
                                            .font(.system(size: 18))
                                        Text("Continue with Google")
                                            .font(.system(size: 16, weight: .medium, design: .rounded))
                                    }
                                    .foregroundColor(.coffeeText)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.coffeeCard)
                                    .cornerRadius(16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
                                    )
                                }
                            }
                            
                            // Sign up link
                            HStack(spacing: 4) {
                                Text("Don't have an account?")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.coffeeTextSecondary)
                                
                                NavigationLink(destination: SignupView().environmentObject(auth)) {
                                    Text("Sign Up")
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        .foregroundColor(.coffeePrimary)
                                }
                            }
                            .padding(.top, 8)
                        }
                        .padding(32)
                    }
                    .background(Color.coffeeCard)
                    .cornerRadius(35)
                    .shadow(color: Color.coffeeShadowStrong, radius: 20, x: 0, y: 10)
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .onAppear {
            // Email field is now properly bound to auth.loginEmail
        }
    }
} 