import SwiftUI

struct GymRowView: View {
    let gym: Gym

    var body: some View {
        HStack(spacing: 20) {
            SafeImageView(imageName: gym.imageName, placeholderSymbol: "figure.strengthtraining.traditional")
                .scaledToFill()
                .frame(width: 70, height: 70)
                .cornerRadius(25)

            VStack(alignment: .leading, spacing: 6) {
                Text(gym.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.coffeeWhite)

                Text(gym.facilities.first ?? "Fitness & Fun")
                    .font(.subheadline)
                    .foregroundColor(.coffeeWhite.opacity(0.8))
                    .lineLimit(1)
            }
            
            Spacer()

            Image(systemName: "chevron.right")
                .font(.body.weight(.semibold))
                .foregroundColor(.coffeeWhite.opacity(0.6))
        }
        .padding()
        .background(Color.coffeePrimary)
        .cornerRadius(30)
        .shadow(color: .coffeePrimary.opacity(0.3), radius: 8, y: 4)
    }
}

struct GymRowView_Previews: PreviewProvider {
    static var previews: some View {
        GymRowView(gym: MockDataService.gyms.first!)
            .padding()
            .background(Color.coffeeBackground)
    }
}
