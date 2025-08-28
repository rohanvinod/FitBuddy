import SwiftUI

struct MessagesView: View {
    // For demonstration, we'll use a subset of mock users as matches.
    let matchedUsers = Array(MockDataService.users.prefix(2))

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(matchedUsers) { user in
                        NavigationLink(destination: ChatView(partnerName: user.name)) {
                            ConversationRowView(user: user, lastMessage: "Tap to start chatting...")
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
    }
}
