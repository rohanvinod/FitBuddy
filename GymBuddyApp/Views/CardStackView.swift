import SwiftUI

struct CardStackView: View {
    @StateObject private var viewModel = CardStackViewModel()
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        VStack {
            ZStack {
                if viewModel.userProfiles.isEmpty {
                    // Enhanced empty state
                    VStack(spacing: 24) {
                        ZStack {
                            Circle()
                                .fill(Color.coffeePrimary.opacity(0.1))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "person.2.circle")
                                .font(.system(size: 60))
                                .foregroundColor(.coffeePrimary)
                        }
                        
                        VStack(spacing: 12) {
                            Text("No More Buddies")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.coffeeText)
                            
                            Text("Check back later for new gym partners!")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeTextSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 60)
                } else {
                    ForEach(viewModel.userProfiles) { userProfile in
                        CardView(userProfile: userProfile)
                            .padding(.horizontal, 30)
                            .zIndex(zIndex(for: userProfile))
                            .offset(x: offsetForCard(userProfile: userProfile), y: 0)
                            .rotationEffect(rotationForCard(userProfile: userProfile))
                            .gesture(
                                isTopCard(userProfile: userProfile) ? createDragGesture() : nil
                            )
                    }
                }
            }
            .padding(.top, 20)

            Spacer()

            // Action Buttons
            HStack(spacing: 25) {
                ActionButton(symbol: "xmark") { viewModel.removeCard() }
                ActionButton(symbol: "heart.fill") { viewModel.removeCard() }
            }
            .padding(.bottom, 40)
        }
        .background(Color.coffeeBackground.edgesIgnoringSafeArea(.all))
    }

    private func createDragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation
            }
            .onEnded { value in
                let translationWidth = value.translation.width
                if abs(translationWidth) > 100 {
                    let direction: SwipeDirection = translationWidth > 0 ? .right : .left
                    swipe(direction)
                } else {
                    withAnimation(.spring()) {
                        dragOffset = .zero
                    }
                }
            }
    }

    private func swipe(_ direction: SwipeDirection) {
        withAnimation(.linear(duration: 0.3)) {
            switch direction {
            case .left:
                dragOffset = CGSize(width: -1000, height: 0)
            case .right:
                dragOffset = CGSize(width: 1000, height: 0)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            viewModel.removeCard()
            dragOffset = .zero
        }
    }

    private func isTopCard(userProfile: UserProfile) -> Bool {
        return viewModel.userProfiles.last?.id == userProfile.id
    }

    private func zIndex(for userProfile: UserProfile) -> Double {
        Double(viewModel.userProfiles.firstIndex(of: userProfile) ?? 0)
    }

    private func offsetForCard(userProfile: UserProfile) -> CGFloat {
        if isTopCard(userProfile: userProfile) {
            return dragOffset.width
        }
        return 0
    }

    private func rotationForCard(userProfile: UserProfile) -> Angle {
        if isTopCard(userProfile: userProfile) {
            return .degrees(Double(dragOffset.width / 20.0))
        }
        return .degrees(0)
    }
}

enum SwipeDirection {
    case left, right
}

// Enhanced Action Buttons
struct ActionButton: View {
    let symbol: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(
                        AnyShapeStyle(
                            LinearGradient(
                                gradient: Gradient(colors: symbol == "xmark" ? [Color.coffeeError, Color.coffeeError.opacity(0.8)] : [Color.coffeeSuccess, Color.coffeeSuccess.opacity(0.8)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    )
                    .frame(width: 60, height: 60)
                    .shadow(color: .coffeeShadowStrong, radius: 10, x: 0, y: 5)
                
                Image(systemName: symbol)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.coffeeCard)
            }
        }
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
