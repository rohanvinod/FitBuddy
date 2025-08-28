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
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 35, style: .continuous))
                        .padding(.horizontal)
                        .padding(.top)

                    // Main Details Card
                    VStack(alignment: .leading, spacing: 25) {
                        Text(gym.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.coffeeText)

                        InfoRow(symbol: "location.fill", title: "Address", content: gym.address)
                        InfoRow(symbol: "clock.fill", title: "Hours", content: gym.hours.joined(separator: "\n"))
                        InfoRow(symbol: "sparkles", title: "Facilities", content: gym.facilities.joined(separator: ", "))

                        // Map View
                        Map(initialPosition: .region(region)) {
                            Marker(gym.name, coordinate: gym.coordinate)
                                .tint(Color.coffeePrimary)
                        }
                        .frame(height: 250)
                        .cornerRadius(25)
                    }
                    .padding(25)
                    .background(Color.coffeeWhite)
                    .cornerRadius(35)
                    .padding()
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
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: symbol)
                .font(.title2)
                .foregroundColor(.coffeePrimary)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.coffeeText)
                Text(content)
                    .font(.body)
                    .foregroundColor(.coffeeText.opacity(0.7))
                    .lineLimit(nil)
            }
            Spacer()
        }
    }
}

// Custom Back Button to match the aesthetic
struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left")
                .font(.title2.weight(.bold))
                .foregroundColor(.coffeeWhite)
                .padding(12)
                .background(Color.coffeePrimary)
                .clipShape(Circle())
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
