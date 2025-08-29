import SwiftUI

struct ChatView: View {
    let partnerName: String
    @EnvironmentObject var chatService: ChatService
    @State private var newMessage: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // Message list
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(chatService.messages(for: partnerName)) { message in
                        ChatBubbleView(message: message)
                    }
                }
                .padding()
            }
            .background(Color.coffeeBackground)

            // Message Input Area
            HStack(spacing: 15) {
                TextField("Message...", text: $newMessage)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(Color.coffeeCard)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
                    )
                
                Button(action: sendMessage) {
                    ZStack {
                        Circle()
                            .fill(
                                AnyShapeStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.coffeePrimary, Color.coffeeSecondary]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                            )
                            .frame(width: 50, height: 50)
                            .shadow(color: .coffeeShadowStrong, radius: 8, x: 0, y: 4)
                        
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.coffeeCard)
                    }
                }
            }
            .padding()
            .background(Color.coffeeBackground.edgesIgnoringSafeArea(.bottom))
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
            ToolbarItem(placement: .principal) {
                Text(partnerName)
                    .font(.title2.weight(.bold))
                    .foregroundColor(.coffeeText)
            }
        }
    }

    private func sendMessage() {
        guard !newMessage.isEmpty else { return }
        chatService.send(message: newMessage, to: partnerName)
        newMessage = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(partnerName: "Jess")
                .environmentObject(ChatService())
        }
    }
}
