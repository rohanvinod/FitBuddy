import SwiftUI

struct CardStackView: View {
    @StateObject private var viewModel = CardStackViewModel()
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        VStack {
            ZStack {
                if viewModel.users.isEmpty {
                    Text("No more buddies to show.")
                        .font(.headline)
                        .foregroundColor(.coffeeText)
                } else {
                    ForEach(viewModel.users) { user in
                        CardView(user: user)
                            .padding(.horizontal, 30)
                            .zIndex(zIndex(for: user))
                            .offset(x: offsetForCard(user: user), y: 0)
                            .rotationEffect(rotationForCard(user: user))
                            .gesture(
                                isTopCard(user: user) ? createDragGesture() : nil
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

    private func isTopCard(user: User) -> Bool {
        return viewModel.users.last?.id == user.id
    }

    private func zIndex(for user: User) -> Double {
        Double(viewModel.users.firstIndex(of: user) ?? 0)
    }

    private func offsetForCard(user: User) -> CGFloat {
        if isTopCard(user: user) {
            return dragOffset.width
        }
        return 0
    }

    private func rotationForCard(user: User) -> Angle {
        if isTopCard(user: user) {
            return .degrees(Double(dragOffset.width / 20.0))
        }
        return .degrees(0)
    }
}

enum SwipeDirection {
    case left, right
}

// Helper View for Action Buttons
struct ActionButton: View {
    let symbol: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.coffeeWhite)
                .padding(25)
                .background(Color.coffeePrimary)
                .clipShape(Circle())
                .shadow(color: .coffeePrimary.opacity(0.4), radius: 10, y: 5)
        }
    }
}

struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackView()
    }
}
