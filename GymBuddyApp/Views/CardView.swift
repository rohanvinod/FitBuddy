import SwiftUI

struct CardView: View {
    let userProfile: UserProfile

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Image Background
            if let firstImage = userProfile.photoImageData.first,
               let uiImage = UIImage(data: firstImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 500)
                    .clipped()
            } else {
                // Placeholder when no images
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.coffeeGradientStart, Color.coffeeGradientEnd]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    VStack(spacing: 20) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.coffeeCard.opacity(0.8))
                        Text("No photo available")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.coffeeCard.opacity(0.8))
                    }
                }
                .frame(height: 500)
            }

            // Gradient Overlay for Text
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.8),
                    Color.black.opacity(0.4),
                    Color.black.opacity(0.1),
                    Color.clear
                ]),
                startPoint: .bottom,
                endPoint: .center
            )

            // User Info Text
            VStack(alignment: .leading, spacing: 16) {
                // Name and Username
                VStack(alignment: .leading, spacing: 4) {
                    Text(userProfile.name)
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.coffeeCard)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)

                    Text("@\(userProfile.username)")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.coffeeCard.opacity(0.8))
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                }

                // Bio
                if let bio = userProfile.bio, !bio.isEmpty {
                    Text(bio)
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.coffeeCard.opacity(0.9))
                        .lineLimit(3)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                }

                // Profile Details
                VStack(spacing: 12) {
                    // Gym Location
                    if !userProfile.gymLocation.isEmpty {
                        HStack(spacing: 12) {
                            Image(systemName: "building.2.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.coffeePrimary)
                                .frame(width: 20)
                            Text(userProfile.gymLocation)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeCard.opacity(0.9))
                                .lineLimit(2)
                        }
                    }
                    
                    // Training Split
                    if !userProfile.trainingSplit.isEmpty {
                        HStack(spacing: 12) {
                            Image(systemName: "dumbbell.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.coffeePrimary)
                                .frame(width: 20)
                            Text(userProfile.trainingSplit)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeCard.opacity(0.9))
                        }
                    }
                    
                    // Experience Level
                    if !userProfile.gymLevel.isEmpty {
                        HStack(spacing: 12) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.coffeePrimary)
                                .frame(width: 20)
                            Text(userProfile.gymLevel)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeCard.opacity(0.9))
                        }
                    }
                }
                .padding(.top, 4)
            }
            .padding(28)
            .padding(.bottom, 24)
        }
        .frame(height: 500)
        .background(Color.coffeeBackground)
        .cornerRadius(35)
        .shadow(color: .coffeeShadowStrong, radius: 20, x: 0, y: 12)
        .overlay(
            RoundedRectangle(cornerRadius: 35)
                .stroke(Color.coffeePrimary.opacity(0.1), lineWidth: 1)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(userProfile: UserProfile(
            name: "Alex Chen",
            username: "alexchen",
            bio: "Looking for a consistent gym partner for morning workouts. I'm into strength training and love pushing each other to new PRs!",
            gymLocation: "City Sports Club, San Ramon",
            trainingSplit: "PPL",
            gymLevel: "Intermediate",
            photoAssetIdentifiers: [],
            photoImageData: []
        ))
        .padding()
        .background(Color.coffeeBackground.edgesIgnoringSafeArea(.all))
    }
}
