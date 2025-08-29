import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.coffeeBackground.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Profile Section
                        VStack(spacing: 24) {
                            // Profile Header
                            VStack(spacing: 20) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.coffeePrimary, Color.coffeeSecondary]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 120, height: 120)
                                        .shadow(color: .coffeeShadowStrong, radius: 15, x: 0, y: 8)
                                    
                                    if let firstImage = auth.currentUserImages.first {
                                        Image(uiImage: firstImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 110, height: 110)
                                            .clipShape(Circle())
                                    } else {
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 50))
                                            .foregroundColor(.coffeeCard)
                                    }
                                }
                                
                                VStack(spacing: 8) {
                                    Text(auth.currentUser?.name ?? "Your Name")
                                        .font(.system(size: 28, weight: .bold, design: .rounded))
                                        .foregroundColor(.coffeeText)
                                    
                                    Text("@\(auth.currentUser?.username ?? "username")")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.coffeeTextSecondary)
                                }
                            }
                            
                            // View Account Button
                            NavigationLink(destination: AccountPreviewView().environmentObject(auth)) {
                                HStack {
                                    Image(systemName: auth.hasProfilePhotos ? "eye.fill" : "photo.badge.plus")
                                        .font(.title3)
                                        .foregroundColor(.coffeeCard)
                                    Text(auth.hasProfilePhotos ? "View My Profile" : "Add Photos & View Profile")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                        .foregroundColor(.coffeeCard)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.coffeeCard.opacity(0.8))
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 16)
                                .background(
                                    AnyShapeStyle(
                                        LinearGradient(
                                            gradient: Gradient(colors: auth.hasProfilePhotos ? [Color.coffeePrimary, Color.coffeeSecondary] : [Color.coffeeWarning, Color.coffeeWarning.opacity(0.8)]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                )
                                .cornerRadius(25)
                                .shadow(color: .coffeeShadowStrong, radius: 8, x: 0, y: 4)
                            }
                        }
                        .padding(.top, 20)
                        
                        // Settings Sections
                        VStack(spacing: 24) {
                            // Account Section
                            SettingsSection(title: "Account") {
                                SettingsRow(icon: "person.fill", title: "Edit Profile", action: {})
                                SettingsRow(icon: "lock.fill", title: "Change Password", action: {})
                                SettingsRow(icon: "shield.fill", title: "Privacy Settings", action: {})
                            }
                            
                            // Preferences Section
                            SettingsSection(title: "Preferences") {
                                // Auto-login toggle
                                HStack {
                                    HStack(spacing: 16) {
                                        Image(systemName: "key.fill")
                                            .font(.title3)
                                            .foregroundColor(.coffeePrimary)
                                            .frame(width: 30)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Auto-login at startup")
                                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                                .foregroundColor(.coffeeText)
                                            if auth.hasStoredCredentials {
                                                Text("Credentials stored")
                                                    .font(.system(size: 12, weight: .medium, design: .rounded))
                                                    .foregroundColor(.coffeeSuccess)
                                            } else {
                                                Text("No credentials stored")
                                                    .font(.system(size: 12, weight: .medium, design: .rounded))
                                                    .foregroundColor(.coffeeWarning)
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: Binding(
                                        get: { auth.autoLoginEnabled },
                                        set: { auth.autoLoginEnabled = $0 }
                                    ))
                                    .toggleStyle(SwitchToggleStyle(tint: .coffeePrimary))
                                }
                                .padding()
                                
                                if auth.hasStoredCredentials && !auth.isAuthenticated {
                                    Button(action: { auth.triggerAutoLogin() }) {
                                        HStack {
                                            Image(systemName: "arrow.clockwise")
                                                .font(.title3)
                                                .foregroundColor(.coffeePrimary)
                                                .frame(width: 30)
                                            Text("Login Now")
                                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                                .foregroundColor(.coffeePrimary)
                                            Spacer()
                                        }
                                        .padding()
                                    }
                                    .padding(.horizontal)
                                }
                                
                                SettingsRow(icon: "bell.fill", title: "Notifications", action: {})
                                SettingsRow(icon: "hand.raised.fill", title: "Privacy", action: {})
                                SettingsRow(icon: "globe", title: "Language", action: {})
                            }
                            
                            // Support Section
                            SettingsSection(title: "Support") {
                                SettingsRow(icon: "questionmark.circle.fill", title: "Help & Support", action: {})
                                SettingsRow(icon: "info.circle.fill", title: "About", action: {})
                                SettingsRow(icon: "envelope.fill", title: "Contact Us", action: {})
                            }
                            
                            // Logout Button
                            Button(action: { auth.logout() }) {
                                HStack {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .font(.title3)
                                        .foregroundColor(.coffeeError)
                                        .frame(width: 30)
                                    Text("Log Out")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                        .foregroundColor(.coffeeError)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.coffeeCard)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.coffeeError.opacity(0.3), lineWidth: 1)
                                )
                                .shadow(color: .coffeeShadow, radius: 5, x: 0, y: 2)
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 50)
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
}

// Reusable Settings Section
struct SettingsSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.coffeeText)
                .padding(.horizontal)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.coffeeCard)
            .cornerRadius(25)
            .shadow(color: .coffeeShadow, radius: 10, x: 0, y: 5)
        }
        .padding(.horizontal)
    }
}

// Reusable Settings Row
struct SettingsRow: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.coffeePrimary)
                    .frame(width: 30)
                Text(title)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.coffeeText)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.coffeeTextSecondary)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel())
    }
}
