import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
            }

            Text(message.message)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(message.isFromCurrentUser ? Color.coffeePrimary : Color.coffeeWhite)
                .foregroundColor(message.isFromCurrentUser ? .coffeeWhite : .coffeeText)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(message.isFromCurrentUser ? Color.clear : Color.coffeeSecondary, lineWidth: 1)
                )

            if !message.isFromCurrentUser {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct ChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatBubbleView(message: MockDataService.messages[0])
            ChatBubbleView(message: MockDataService.messages[1])
        }
        .padding()
        .background(Color.coffeeBackground)
    }
}
