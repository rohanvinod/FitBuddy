import SwiftUI

struct ConversationRowView: View {
    let user: User
    let lastMessage: String

    var body: some View {
        HStack(spacing: 16) {
            SafeImageView(imageName: user.profileImageName, placeholderSymbol: "person.crop.circle.fill")
                .scaledToFill()
                .frame(width: 65, height: 65)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 6) {
                Text(user.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.coffeeWhite)

                Text(lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.coffeeWhite.opacity(0.8))
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding()
        .background(Color.coffeePrimary)
        .cornerRadius(30)
    }
}

struct ConversationRowView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationRowView(user: MockDataService.users.first!, lastMessage: "Usually in the mornings around 7 AM.")
            .padding()
            .background(Color.coffeeBackground)
    }
}
