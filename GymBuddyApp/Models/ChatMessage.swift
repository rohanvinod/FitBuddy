import Foundation

struct ChatMessage: Identifiable, Hashable {
    let id = UUID()
    let message: String
    let isFromCurrentUser: Bool
    let timestamp: Date
}
