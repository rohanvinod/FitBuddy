import SwiftUI

struct GymFinderView: View {
    let gyms = MockDataService.gyms

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(gyms) { gym in
                        NavigationLink(destination: GymDetailView(gym: gym)) {
                            GymRowView(gym: gym)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.top)
            }
            .background(Color.coffeeBackground.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Find a Gym")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.coffeePrimary)
                }
            }
        }
    }
}

struct GymFinderView_Previews: PreviewProvider {
    static var previews: some View {
        GymFinderView()
    }
}
