import SwiftUI
import MapKit

struct GymDetailView: View {
    let gym: Gym
    @State private var region: MKCoordinateRegion

    init(gym: Gym) {
        self.gym = gym
        _region = State(initialValue: MKCoordinateRegion(
            center: gym.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }

    var body: some View {
        ZStack {
            Color.coffeeBackground.edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 0) {
                    // Top Image
                    SafeImageView(imageName: gym.imageName, placeholderSymbol: "figure.strengthtraining.traditional")
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 35))
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .shadow(color: Color.coffeeShadowStrong, radius: 15, x: 0, y: 8)

                    // Main Details Card
                    VStack(alignment: .leading, spacing: 28) {
                        // Gym Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text(gym.name)
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.coffeeText)
                            
                            Text("Premium Fitness Destination")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeTextSecondary)
                        }

                        // Info Rows
                        VStack(spacing: 20) {
                            InfoRow(symbol: "location.fill", title: "Address", content: gym.address)
                            InfoRow(symbol: "clock.fill", title: "Hours", content: gym.hours.joined(separator: "\n"))
                            InfoRow(symbol: "sparkles", title: "Facilities", content: gym.facilities.joined(separator: ", "))
                        }

                        // Map View
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Location")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.coffeeText)
                            
                            Map(initialPosition: .region(region)) {
                                Marker(gym.name, coordinate: gym.coordinate)
                                    .tint(Color.coffeePrimary)
                            }
                            .frame(height: 280)
                            .cornerRadius(35)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.coffeePrimary.opacity(0.1), lineWidth: 1)
                            )
                            .shadow(color: Color.coffeeShadow, radius: 10, x: 0, y: 5)
                        }
                    }
                    .padding(28)
                    .background(Color.coffeeCard)
                    .cornerRadius(35)
                    .shadow(color: Color.coffeeShadowStrong, radius: 20, x: 0, y: 10)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
        }
    }
}

// Helper view for info rows
struct InfoRow: View {
    let symbol: String
    let title: String
    let content: String

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: symbol)
                .font(.system(size: 22))
                .foregroundColor(.coffeePrimary)
                .frame(width: 35)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.coffeeText)
                Text(content)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.coffeeTextSecondary)
                    .lineLimit(nil)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

// Custom Back Button to match the aesthetic
struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            ZStack {
                Circle()
                    .fill(Color.coffeeCard)
                    .frame(width: 44, height: 44)
                    .shadow(color: Color.coffeeShadowStrong, radius: 8, x: 0, y: 4)
                
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.coffeePrimary)
            }
        }
    }
}

struct GymDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GymDetailView(gym: MockDataService.gyms[0])
        }
    }
}
