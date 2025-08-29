import SwiftUI

struct GymFinderView: View {
    let gyms = MockDataService.gyms

    var body: some View {
        NavigationView {
            ZStack {
                Color.coffeeBackground.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Header
                        VStack(spacing: 12) {
                            Text("Find a Gym")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.coffeeText)
                            
                            Text("Discover fitness facilities near you")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeTextSecondary)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                        
                        // Search Bar (Placeholder for future implementation)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.coffeeTextSecondary)
                                .font(.system(size: 18))
                            
                            Text("Search gyms by location...")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeTextSecondary)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.coffeeCard)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.coffeePrimary.opacity(0.1), lineWidth: 1)
                        )
                        .shadow(color: .coffeeShadow, radius: 5, x: 0, y: 2)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                        
                        // Gyms List
                        VStack(spacing: 0) {
                            ForEach(gyms) { gym in
                                NavigationLink(destination: GymDetailView(gym: gym)) {
                                    GymRowView(gym: gym)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                if gym.id != gyms.last?.id {
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
                        
                        Spacer(minLength: 50)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct GymFinderView_Previews: PreviewProvider {
    static var previews: some View {
        GymFinderView()
    }
}
