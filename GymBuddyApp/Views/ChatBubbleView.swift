import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
            }

            Text(message.message)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
                .background(
                    message.isFromCurrentUser ? 
                    AnyShapeStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.coffeePrimary, Color.coffeeSecondary]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    ) : AnyShapeStyle(Color.coffeeCard)
                )
                .foregroundColor(message.isFromCurrentUser ? .coffeeCard : .coffeeText)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(
                            message.isFromCurrentUser ? Color.clear : Color.coffeePrimary.opacity(0.2),
                            lineWidth: 1
                        )
                )
                .shadow(
                    color: message.isFromCurrentUser ? .coffeeShadowStrong : .coffeeShadow,
                    radius: message.isFromCurrentUser ? 8 : 4,
                    x: 0,
                    y: message.isFromCurrentUser ? 4 : 2
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
        VStack(spacing: 20) {
            ChatBubbleView(message: ChatMessage(
                message: "Hey! Saw we matched. I'm also into strength training.",
                isFromCurrentUser: false,
                timestamp: Date()
            ))
            ChatBubbleView(message: ChatMessage(
                message: "Awesome! When do you usually work out?",
                isFromCurrentUser: true,
                timestamp: Date()
            ))
        }
        .padding()
        .background(Color.coffeeBackground)
    }
}
