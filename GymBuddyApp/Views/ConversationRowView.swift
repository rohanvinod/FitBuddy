import SwiftUI

struct ConversationRowView: View {
    let userProfile: UserProfile
    let lastMessage: String

    var body: some View {
        HStack(spacing: 16) {
            // Profile Image
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.coffeePrimary, Color.coffeeSecondary]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 65, height: 65)
                
                if let firstImage = userProfile.photoImageData.first,
                   let uiImage = UIImage(data: firstImage) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.coffeeCard)
                }
            }
            .shadow(color: .coffeeShadow, radius: 5, x: 0, y: 2)

            // Message Content
            VStack(alignment: .leading, spacing: 6) {
                Text(userProfile.name)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.coffeeText)
                    .lineLimit(1)

                Text(lastMessage)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.coffeeTextSecondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            // Chevron indicator
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.coffeeTextSecondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.coffeeCard)
    }
}

struct ConversationRowView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationRowView(
            userProfile: UserProfile(
                name: "Alex Chen",
                username: "alexchen",
                bio: "Looking for a consistent gym partner for morning workouts. I'm into strength training and love pushing each other to new PRs!",
                gymLocation: "City Sports Club, San Ramon",
                trainingSplit: "PPL",
                gymLevel: "Intermediate",
                photoAssetIdentifiers: [],
                photoImageData: []
            ),
            lastMessage: "Usually in the mornings around 7 AM."
        )
        .padding()
        .background(Color.coffeeBackground)
    }
}
