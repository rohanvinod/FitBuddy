import SwiftUI

struct ChatView: View {
    let partnerName: String
    @State private var messages = MockDataService.messages
    @State private var newMessage: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // Message list
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(messages) { message in
                        ChatBubbleView(message: message)
                    }
                }
                .padding()
            }
            .background(Color.coffeeBackground)

            // Message Input Area
            HStack(spacing: 15) {
                TextField("Message...", text: $newMessage)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.coffeeWhite)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.coffeeSecondary, lineWidth: 1)
                    )
                    .font(.body)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .foregroundColor(.coffeeWhite)
                        .padding(15)
                        .background(Color.coffeePrimary)
                        .clipShape(Circle())
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
        if !newMessage.isEmpty {
            let message = ChatMessage(message: newMessage, isFromCurrentUser: true, timestamp: Date())
            messages.append(message)
            newMessage = ""
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(partnerName: "Jess")
        }
    }
}
