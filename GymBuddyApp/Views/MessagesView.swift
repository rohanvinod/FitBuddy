import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var chatService: ChatService

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(chatService.conversations) { convo in
                        NavigationLink(destination: ChatView(partnerName: convo.partnerName)) {
                            ConversationRowView(user: User(name: convo.partnerName, age: 0, profileImageName: "", interests: [], bio: ""), lastMessage: convo.messages.last?.message ?? "Tap to start chatting...")
                        }
                    }
                }
                .padding()
            }
            .background(Color.coffeeBackground.edgesIgnoringSafeArea(.all))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Messages")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.coffeeText)
                }
            }
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
            .environmentObject(ChatService())
    }
}
