import Foundation
import Combine

final class ChatService: ObservableObject {
    struct Conversation: Identifiable, Hashable {
        let id: UUID
        let partnerName: String
        var messages: [ChatMessage]

        init(id: UUID = UUID(), partnerName: String, messages: [ChatMessage] = []) {
            self.id = id
            self.partnerName = partnerName
            self.messages = messages
        }
    }

    @Published private(set) var conversations: [Conversation] = []

    init() {
        // Seed with mock conversations
        conversations = [
            Conversation(partnerName: "Alex", messages: MockDataService.messages),
            Conversation(partnerName: "Jess", messages: MockDataService.messages)
        ]
    }

    func send(message text: String, to partnerName: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let newMessage = ChatMessage(message: text, isFromCurrentUser: true, timestamp: Date())
        if let index = conversations.firstIndex(where: { $0.partnerName == partnerName }) {
            conversations[index].messages.append(newMessage)
        } else {
            conversations.append(Conversation(partnerName: partnerName, messages: [newMessage]))
        }
    }

    func messages(for partnerName: String) -> [ChatMessage] {
        conversations.first(where: { $0.partnerName == partnerName })?.messages ?? []
    }
} 