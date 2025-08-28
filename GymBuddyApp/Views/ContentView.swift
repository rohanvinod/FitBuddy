import SwiftUI

struct ContentView: View {
    @StateObject private var chatService = ChatService()

    var body: some View {
        MainTabView()
            .environmentObject(chatService)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
