import SwiftUI

struct CardView: View {
    let user: User

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Image Background
            SafeImageView(imageName: user.profileImageName, placeholderSymbol: "person.fill")
                .scaledToFill()
                .frame(height: 450)

            // Gradient Overlay for Text
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0)]),
                startPoint: .bottom,
                endPoint: .center
            )

            // User Info Text
            VStack(alignment: .leading, spacing: 12) {
                Text("\(user.name), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(user.bio)
                    .font(.headline)
                    .lineLimit(3)

                HStack {
                    ForEach(user.interests, id: \.self) { interest in
                        Text(interest)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.coffeeSecondary.opacity(0.8))
                            .cornerRadius(20)
                    }
                }
            }
            .foregroundColor(.coffeeWhite)
            .padding(24)
            .padding(.bottom, 16)
        }
        .frame(height: 450)
        .background(Color.coffeeSecondary)
        .cornerRadius(35)
        .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 8)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(user: MockDataService.users.first!)
            .padding()
            .background(Color.coffeeBackground.edgesIgnoringSafeArea(.all))
    }
}
