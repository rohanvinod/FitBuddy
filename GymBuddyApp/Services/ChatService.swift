import Foundation
import Combine

final class ChatService: ObservableObject {
    struct Conversation: Identifiable, Hashable {
        let id: UUID
        let partnerProfile: UserProfile
        var messages: [ChatMessage]

        init(id: UUID = UUID(), partnerProfile: UserProfile, messages: [ChatMessage] = []) {
            self.id = id
            self.partnerProfile = partnerProfile
            self.messages = messages
        }
    }

    @Published private(set) var conversations: [Conversation] = []

    init() {
        // Create sample conversations based on the sample user profiles
        conversations = createSampleConversations()
    }

    func send(message text: String, to partnerName: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let newMessage = ChatMessage(message: text, isFromCurrentUser: true, timestamp: Date())
        if let index = conversations.firstIndex(where: { $0.partnerProfile.name == partnerName }) {
            conversations[index].messages.append(newMessage)
        } else {
            // Create a new conversation if it doesn't exist
            let newProfile = UserProfile(
                name: partnerName,
                username: partnerName.lowercased(),
                bio: "New gym partner",
                gymLocation: "",
                trainingSplit: "",
                gymLevel: "",
                photoAssetIdentifiers: [],
                photoImageData: []
            )
            conversations.append(Conversation(partnerProfile: newProfile, messages: [newMessage]))
        }
    }

    func messages(for partnerName: String) -> [ChatMessage] {
        conversations.first(where: { $0.partnerProfile.name == partnerName })?.messages ?? []
    }
    
    private func createSampleConversations() -> [Conversation] {
        let alexProfile = UserProfile(
            name: "Alex Chen",
            username: "alexchen",
            bio: "Looking for a consistent gym partner for morning workouts. I'm into strength training and love pushing each other to new PRs!",
            gymLocation: "City Sports Club, San Ramon",
            trainingSplit: "PPL",
            gymLevel: "Intermediate",
            photoAssetIdentifiers: [],
            photoImageData: []
        )
        
        let jessProfile = UserProfile(
            name: "Jessica Rodriguez",
            username: "jessrodriguez",
            bio: "CrossFit enthusiast who loves high-intensity workouts. Looking for someone to join me for weekend WODs and keep me motivated!",
            gymLocation: "24 Hour Fitness, Dublin",
            trainingSplit: "Upper/Lower",
            gymLevel: "Advanced",
            photoAssetIdentifiers: [],
            photoImageData: []
        )
        
        return [
            Conversation(
                partnerProfile: alexProfile,
                messages: [
                    ChatMessage(message: "Hey! Saw we matched. I'm also into strength training.", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-3600)),
                    ChatMessage(message: "Awesome! When do you usually work out?", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-3540)),
                    ChatMessage(message: "Usually in the mornings around 7 AM. Perfect for PPL splits!", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-3480)),
                    ChatMessage(message: "Perfect, me too. Let's plan something for next week?", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-3420))
                ]
            ),
            Conversation(
                partnerProfile: jessProfile,
                messages: [
                    ChatMessage(message: "Hi! I noticed we're both at 24 Hour Fitness in Dublin.", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-7200)),
                    ChatMessage(message: "That's awesome! What's your training schedule like?", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-7140)),
                    ChatMessage(message: "I do Upper/Lower splits, usually weekends for the intense stuff!", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-7080))
                ]
            )
        ]
    }
} 