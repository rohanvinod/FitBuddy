import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var chatService: ChatService

    var body: some View {
        NavigationView {
            ZStack {
                Color.coffeeBackground.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header
                        VStack(spacing: 8) {
                            Text("Messages")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.coffeeText)
                            
                            Text("Connect with your gym partners")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeTextSecondary)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                        
                        // Conversations List
                        if chatService.conversations.isEmpty {
                            // Empty State
                            VStack(spacing: 24) {
                                ZStack {
                                    Circle()
                                        .fill(Color.coffeePrimary.opacity(0.1))
                                        .frame(width: 120, height: 120)
                                    
                                    Image(systemName: "message.circle")
                                        .font(.system(size: 60))
                                        .foregroundColor(.coffeePrimary)
                                }
                                
                                VStack(spacing: 12) {
                                    Text("No Messages Yet")
                                        .font(.system(size: 24, weight: .bold, design: .rounded))
                                        .foregroundColor(.coffeeText)
                                    
                                    Text("Start swiping to find gym partners and begin conversations!")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.coffeeTextSecondary)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.top, 60)
                        } else {
                            VStack(spacing: 0) {
                                ForEach(chatService.conversations) { convo in
                                    NavigationLink(destination: ChatView(partnerName: convo.partnerProfile.name)) {
                                        ConversationRowView(
                                            userProfile: convo.partnerProfile,
                                            lastMessage: convo.messages.last?.message ?? "Tap to start chatting..."
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    if convo.id != chatService.conversations.last?.id {
                                        Divider()
                                            .background(Color.coffeeTextLight.opacity(0.2))
                                            .padding(.horizontal, 20)
                                    }
                                }
                            }
                            .background(Color.coffeeCard)
                            .cornerRadius(25)
                            .shadow(color: .coffeeShadow, radius: 10, x: 0, y: 5)
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer(minLength: 50)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
            .environmentObject(ChatService())
    }
}
