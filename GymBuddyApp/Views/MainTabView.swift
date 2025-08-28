import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CardStackView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Buddies")
                }

            GymFinderView()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Gyms")
                }

            MessagesView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Messages")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .accentColor(.coffeePrimary)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
