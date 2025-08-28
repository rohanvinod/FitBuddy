import SwiftUI
import PhotosUI

struct SignupView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var thumbnails: [Image] = []

    let gymLevels = ["Beginner", "Intermediate", "Advanced"]
    let splits = ["Arnold", "Upper/Lower", "PPL", "Full Body", "Custom"]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Create your account")
                    .font(.title.weight(.bold))
                    .foregroundColor(.coffeeText)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Form Card
                VStack(alignment: .leading, spacing: 14) {
                    Group {
                        LabeledField(icon: "person.fill", placeholder: "Full name", text: $auth.name)
                        LabeledField(icon: "at", placeholder: "Username", text: $auth.username)
                        LabeledTextEditor(icon: "text.justify", placeholder: "Bio (optional)", text: $auth.bio)
                        LabeledField(icon: "building.2.fill", placeholder: "Gym membership location", text: $auth.gymLocation)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Training split")
                            .font(.subheadline).foregroundColor(.coffeeSecondary)
                        Picker("Training split", selection: $auth.trainingSplit) {
                            ForEach(splits, id: \.self) { split in
                                Text(split).tag(split)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .background(Color.coffeeWhite)
                        .cornerRadius(12)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Gym level")
                            .font(.subheadline).foregroundColor(.coffeeSecondary)
                        Picker("Gym level", selection: $auth.gymLevel) {
                            ForEach(gymLevels, id: \.self) { level in
                                Text(level).tag(level)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        SecureFieldRow(placeholder: "Password (min 6 characters)", text: $auth.password)
                        SecureFieldRow(placeholder: "Confirm password", text: $auth.confirmPassword)
                        if !auth.password.isEmpty || !auth.confirmPassword.isEmpty {
                            Text(passwordValidationMessage)
                                .font(.footnote)
                                .foregroundColor(passwordsValid ? .green : .red)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Profile photos (up to 5)")
                            .font(.subheadline).foregroundColor(.coffeeSecondary)

                        PhotosPicker(selection: $selectedItems, maxSelectionCount: 5, matching: .images) {
                            HStack {
                                Image(systemName: "photo.on.rectangle.angled")
                                Text("Select photos")
                                Spacer()
                            }
                            .padding()
                            .background(Color.coffeeWhite)
                            .cornerRadius(12)
                        }

                        if !thumbnails.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(thumbnails.indices, id: \.self) { idx in
                                        thumbnails[idx]
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .clipped()
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }
                    }

                    Button(action: handleSignup) {
                        Text("Create Account")
                            .fontWeight(.semibold)
                            .foregroundColor(.coffeeWhite)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.coffeePrimary)
                            .cornerRadius(12)
                    }
                    .disabled(!formValid)
                    .opacity(formValid ? 1 : 0.6)
                }
                .padding(20)
                .background(Color.coffeeBackground)
                .cornerRadius(16)
            }
            .padding(24)
        }
        .background(Color.coffeeBackground.edgesIgnoringSafeArea(.all))
        .onChange(of: selectedItems) { _, newItems in
            Task { await loadAssets(from: newItems) }
        }
    }

    private var passwordsValid: Bool {
        !auth.password.isEmpty && auth.password == auth.confirmPassword && auth.password.count >= 6
    }

    private var passwordValidationMessage: String {
        passwordsValid ? "Passwords match" : "Passwords must match and be at least 6 characters"
    }

    private var formValid: Bool {
        !auth.name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !auth.username.trimmingCharacters(in: .whitespaces).isEmpty &&
        !auth.gymLocation.trimmingCharacters(in: .whitespaces).isEmpty &&
        passwordsValid
    }

    private func loadAssets(from items: [PhotosPickerItem]) async {
        thumbnails.removeAll()
        var identifiers: [String] = []
        for item in items {
            if let id = item.itemIdentifier { identifiers.append(id) }
            if let data = try? await item.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                thumbnails.append(Image(uiImage: uiImage))
            }
        }
        auth.photoAssetIdentifiers = identifiers
    }

    private func handleSignup() {
        auth.signup()
    }
}

private struct LabeledField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: icon).foregroundColor(.coffeeSecondary)
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .foregroundColor(.coffeeText)
        }
        .padding()
        .background(Color.coffeeWhite)
        .cornerRadius(12)
    }
}

private struct LabeledTextEditor: View {
    let icon: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack { Image(systemName: icon).foregroundColor(.coffeeSecondary); Text(placeholder).foregroundColor(.coffeeSecondary) }
            TextEditor(text: $text)
                .frame(minHeight: 80)
                .padding(8)
                .background(Color.coffeeWhite)
                .cornerRadius(12)
                .foregroundColor(.coffeeText)
        }
    }
}

private struct SecureFieldRow: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "lock.fill").foregroundColor(.coffeeSecondary)
            SecureField(placeholder, text: $text)
                .textContentType(.newPassword)
                .foregroundColor(.coffeeText)
        }
        .padding()
        .background(Color.coffeeWhite)
        .cornerRadius(12)
    }
} 