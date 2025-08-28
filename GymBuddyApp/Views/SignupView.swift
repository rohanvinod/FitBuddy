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
                        LabeledField(icon: "person.fill", placeholder: "Name", text: $auth.name)
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
                    .disabled(auth.name.trimmingCharacters(in: .whitespaces).isEmpty || auth.gymLocation.isEmpty)
                    .opacity(auth.name.trimmingCharacters(in: .whitespaces).isEmpty || auth.gymLocation.isEmpty ? 0.6 : 1)
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
        }
        .padding()
        .background(Color.coffeeWhite)
        .cornerRadius(12)
    }
} 