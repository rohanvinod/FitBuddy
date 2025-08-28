import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var name: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("FitBuddy")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.coffeeText)

                TextField("Your name", text: $name)
                    .textContentType(.name)
                    .padding()
                    .background(Color.coffeeWhite)
                    .cornerRadius(8)

                Button(action: { auth.login(name: name) }) {
                    Text("Log In")
                        .fontWeight(.semibold)
                        .foregroundColor(.coffeeWhite)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.coffeePrimary)
                        .cornerRadius(12)
                }
                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)

                NavigationLink(destination: SignupView().environmentObject(auth)) {
                    Text("Create an account")
                        .foregroundColor(.coffeePrimary)
                }

                Spacer()
            }
            .padding()
            .background(Color.coffeeBackground.edgesIgnoringSafeArea(.all))
        }
    }
} 