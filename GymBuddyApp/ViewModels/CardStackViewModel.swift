import Combine
import SwiftUI

class CardStackViewModel: ObservableObject {
    @Published var users: [User] = []

    init() {
        self.users = MockDataService.users.reversed()
    }

    func removeCard() {
        if !users.isEmpty {
            users.removeLast()
        }
    }
}
