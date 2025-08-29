import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CardStackView()
                .tabItem {
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == 0 ? "person.2.fill" : "person.2")
                            .font(.system(size: 20))
                        Text("Buddies")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                    }
                }
                .tag(0)

            GymFinderView()
                .tabItem {
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == 1 ? "mappin.and.ellipse.fill" : "mappin.and.ellipse")
                            .font(.system(size: 20))
                        Text("Gyms")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                    }
                }
                .tag(1)

            MessagesView()
                .tabItem {
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == 2 ? "message.fill" : "message")
                            .font(.system(size: 20))
                        Text("Messages")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                    }
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    VStack(spacing: 4) {
                        Image(systemName: selectedTab == 3 ? "gearshape.fill" : "gearshape")
                            .font(.system(size: 20))
                        Text("Settings")
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                    }
                }
                .tag(3)
        }
        .accentColor(.coffeePrimary)
        .onAppear {
            // Customize tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.coffeeCard)
            
            // Normal state
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.coffeeTextSecondary)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(Color.coffeeTextSecondary),
                .font: UIFont.systemFont(ofSize: 12, weight: .medium)
            ]
            
            // Selected state
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.coffeePrimary)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(Color.coffeePrimary),
                .font: UIFont.systemFont(ofSize: 12, weight: .semibold)
            ]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
