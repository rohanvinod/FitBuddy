import SwiftUI

struct GymRowView: View {
    let gym: Gym

    var body: some View {
        HStack(spacing: 20) {
            // Gym Image
            SafeImageView(imageName: gym.imageName, placeholderSymbol: "figure.strengthtraining.traditional")
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.coffeePrimary.opacity(0.1), lineWidth: 1)
                )
                .shadow(color: Color.coffeeShadow, radius: 5, x: 0, y: 2)

            // Gym Info
            VStack(alignment: .leading, spacing: 8) {
                Text(gym.name)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.coffeeText)
                    .lineLimit(2)

                Text(gym.facilities.first ?? "Fitness & Fun")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.coffeeTextSecondary)
                    .lineLimit(1)
                
                // Hours info
                if let firstHour = gym.hours.first {
                    HStack(spacing: 6) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.coffeePrimary)
                        Text(firstHour)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(.coffeeTextLight)
                    }
                }
            }
            
            Spacer()

            // Chevron indicator
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.coffeeTextSecondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.coffeeCard)
    }
}

struct GymRowView_Previews: PreviewProvider {
    static var previews: some View {
        GymRowView(gym: MockDataService.gyms.first!)
            .padding()
            .background(Color.coffeeBackground)
    }
}
