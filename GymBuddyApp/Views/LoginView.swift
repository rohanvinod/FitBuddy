import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var name: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 8) {
                Text("FitBuddy")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.coffeeWhite)
                Text("Find your perfect gym partner")
                    .font(.subheadline)
                    .foregroundColor(.coffeeWhite.opacity(0.8))
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
            .padding(.bottom, 32)
            .background(Color.coffeePrimary)

            // Form Card
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome back")
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.coffeeText)

                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.coffeeSecondary)
                        TextField("Name", text: $name)
                            .textContentType(.name)
                    }
                    .padding()
                    .background(Color.coffeeWhite)
                    .cornerRadius(12)
                }

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
                .opacity(name.trimmingCharacters(in: .whitespaces).isEmpty ? 0.6 : 1)

                HStack {
                    Rectangle().frame(height: 1).foregroundColor(Color.coffeeSecondary.opacity(0.3))
                    Text("or")
                        .foregroundColor(.coffeeSecondary)
                    Rectangle().frame(height: 1).foregroundColor(Color.coffeeSecondary.opacity(0.3))
                }

                HStack(spacing: 12) {
                    Button { } label: {
                        HStack { Image(systemName: "apple.logo"); Text("Continue with Apple") }
                            .foregroundColor(.coffeeWhite)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }

                NavigationLink(destination: SignupView().environmentObject(auth)) {
                    HStack(spacing: 4) {
                        Text("New here?")
                        Text("Create an account").fontWeight(.semibold)
                    }
                    .foregroundColor(.coffeePrimary)
                }
                .padding(.top, 4)
            }
            .padding(24)
            .background(Color.coffeeBackground)
            .frame(maxWidth: .infinity, alignment: .top)

            Spacer()
        }
        .background(Color.coffeeBackground.edgesIgnoringSafeArea(.all))
    }
} 