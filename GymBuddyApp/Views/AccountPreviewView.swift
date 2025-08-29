import SwiftUI
import PhotosUI

struct AccountPreviewView: View {
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.coffeeBackground.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Profile Preview Card
                        VStack(spacing: 0) {
                            // Profile Images Section
                            if !auth.currentUserImages.isEmpty {
                                TabView {
                                    ForEach(auth.currentUserImages.indices, id: \.self) { index in
                                        Image(uiImage: auth.currentUserImages[index])
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 400)
                                            .clipped()
                                    }
                                }
                                .frame(height: 400)
                                .tabViewStyle(PageTabViewStyle())
                                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            } else {
                                // Placeholder when no images
                                ZStack {
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.coffeeGradientStart, Color.coffeeGradientEnd]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                    VStack(spacing: 20) {
                                        Image(systemName: "photo.on.rectangle.angled")
                                            .font(.system(size: 60))
                                            .foregroundColor(.coffeeCard.opacity(0.8))
                                        VStack(spacing: 8) {
                                            Text("No profile photos")
                                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                                .foregroundColor(.coffeeCard)
                                            Text("Add photos to make your profile stand out!")
                                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                                .foregroundColor(.coffeeCard.opacity(0.8))
                                                .multilineTextAlignment(.center)
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                                .frame(height: 400)
                            }
                            
                            // Profile Info Section
                            VStack(alignment: .leading, spacing: 24) {
                                // Name and Username
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(auth.currentUser?.name ?? "Your Name")
                                        .font(.system(size: 32, weight: .bold, design: .rounded))
                                        .foregroundColor(.coffeeText)
                                    
                                    Text("@\(auth.currentUser?.username ?? "username")")
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .foregroundColor(.coffeeTextSecondary)
                                }
                                
                                // Bio
                                if let bio = auth.currentUser?.bio, !bio.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Bio")
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                            .foregroundColor(.coffeeText)
                                        Text(bio)
                                            .font(.system(size: 16, weight: .medium, design: .rounded))
                                            .foregroundColor(.coffeeTextSecondary)
                                            .lineLimit(nil)
                                    }
                                }
                                
                                // Profile Details
                                VStack(spacing: 20) {
                                    ProfileDetailRow(icon: "building.2.fill", title: "Gym Location", value: auth.currentUser?.gymLocation ?? "Not specified")
                                    ProfileDetailRow(icon: "dumbbell.fill", title: "Training Split", value: auth.currentUser?.trainingSplit ?? "Not specified")
                                    ProfileDetailRow(icon: "star.fill", title: "Experience Level", value: auth.currentUser?.gymLevel ?? "Not specified")
                                }
                                
                                // Photo Count
                                HStack {
                                    Image(systemName: "photo.fill")
                                        .foregroundColor(.coffeePrimary)
                                        .font(.system(size: 18))
                                    Text("\(auth.currentUserImages.count) profile photo\(auth.currentUserImages.count == 1 ? "" : "s")")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.coffeeTextSecondary)
                                    Spacer()
                                }
                                .padding(.top, 8)
                            }
                            .padding(28)
                            .background(Color.coffeeCard)
                        }
                        .cornerRadius(30)
                        .shadow(color: .coffeeShadowStrong, radius: 20, x: 0, y: 10)
                        
                        // How Others See You Info
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Image(systemName: "eye.fill")
                                    .foregroundColor(.coffeePrimary)
                                    .font(.system(size: 24))
                                Text("How others see you")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundColor(.coffeeText)
                            }
                            
                            VStack(spacing: 16) {
                                AccountInfoRow(icon: "person.2.fill", text: "This is exactly how your profile appears to potential gym partners")
                                AccountInfoRow(icon: "photo.fill", text: "Your photos are displayed prominently to showcase your fitness journey")
                                AccountInfoRow(icon: "location.fill", text: "Your gym location helps others find nearby workout partners")
                                AccountInfoRow(icon: "dumbbell.fill", text: "Your training split and experience level help match you with compatible partners")
                            }
                            .padding(24)
                            .background(Color.coffeeCard)
                            .cornerRadius(25)
                            .shadow(color: .coffeeShadow, radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Account Preview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.coffeePrimary)
                }
            }
        }
    }
}

struct ProfileDetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.coffeePrimary)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.coffeeTextSecondary)
                Text(value.isEmpty ? "Not specified" : value)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.coffeeText)
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
    }
}

struct AccountInfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.coffeePrimary)
                .frame(width: 28)
            
            Text(text)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.coffeeText)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}

struct AccountPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        AccountPreviewView()
            .environmentObject(AuthViewModel())
    }
} 