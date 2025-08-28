import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.coffeeBackground.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Profile Section
                        VStack {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 120))
                                .foregroundColor(.coffeePrimary)
                            Text("Your Name")
                                .font(.title.weight(.bold))
                                .foregroundColor(.coffeeText)
                        }
                        .padding(.top, 40)
                        
                        // Settings Sections
                        SettingsSection(title: "Account") {
                            SettingsRow(icon: "person.fill", title: "Edit Profile")
                            SettingsRow(icon: "lock.fill", title: "Change Password")
                        }
                        
                        SettingsSection(title: "Preferences") {
                            SettingsRow(icon: "bell.fill", title: "Notifications")
                            SettingsRow(icon: "hand.raised.fill", title: "Privacy")
                        }
                        
                        SettingsSection(title: "Support") {
                            SettingsRow(icon: "questionmark.circle.fill", title: "Help & Support")
                            SettingsRow(icon: "info.circle.fill", title: "About")
                        }
                        
                        Spacer()
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
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2.weight(.bold))
                .foregroundColor(.coffeeText)
                .padding(.horizontal)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.coffeeWhite)
            .cornerRadius(20)
        }
        .padding(.horizontal)
    }
}

// Reusable Settings Row
struct SettingsRow: View {
    let icon: String
    let title: String

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.coffeePrimary)
                    .frame(width: 30)
                Text(title)
                    .font(.body)
                    .foregroundColor(.coffeeText)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.coffeeText.opacity(0.4))
            }
            .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
