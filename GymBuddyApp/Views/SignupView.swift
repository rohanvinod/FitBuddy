import SwiftUI
import PhotosUI

struct SignupView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var selectedItems: [PhotosPickerItem] = []

    let gymLevels = ["Beginner", "Intermediate", "Advanced"]
    let splits = ["Arnold", "Upper/Lower", "PPL", "Full Body", "Custom"]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Create Account")
                    .font(.title.weight(.bold))
                    .foregroundColor(.coffeeText)

                Group {
                    TextField("Name", text: $auth.name)
                        .textContentType(.name)
                        .padding()
                        .background(Color.coffeeWhite)
                        .cornerRadius(8)

                    TextField("Gym membership location", text: $auth.gymLocation)
                        .padding()
                        .background(Color.coffeeWhite)
                        .cornerRadius(8)

                    Picker("Training split", selection: $auth.trainingSplit) {
                        ForEach(splits, id: \.self) { split in
                            Text(split).tag(split)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding()
                    .background(Color.coffeeWhite)
                    .cornerRadius(8)

                    Picker("Gym level", selection: $auth.gymLevel) {
                        ForEach(gymLevels, id: \.self) { level in
                            Text(level).tag(level)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Profile photos")
                        .font(.headline)
                        .foregroundColor(.coffeeText)

                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 5, matching: .images) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                            Text("Select up to 5 photos")
                            Spacer()
                        }
                        .padding()
                        .background(Color.coffeeWhite)
                        .cornerRadius(8)
                    }

                    if !selectedItems.isEmpty {
                        Text("Selected: \(selectedItems.count)")
                            .font(.subheadline)
                            .foregroundColor(.coffeeSecondary)
                    }
                }

                Button(action: handleSignup) {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                        .foregroundColor(.coffeeWhite)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.coffeePrimary)
                        .cornerRadius(12)
                }
                .disabled(auth.name.trimmingCharacters(in: .whitespaces).isEmpty || auth.gymLocation.isEmpty)

                Spacer(minLength: 20)
            }
            .padding()
        }
        .background(Color.coffeeBackground.edgesIgnoringSafeArea(.all))
        .onChange(of: selectedItems) { _, newItems in
            Task { await loadAssetIdentifiers(from: newItems) }
        }
    }

    private func loadAssetIdentifiers(from items: [PhotosPickerItem]) async {
        var identifiers: [String] = []
        for item in items {
            if let id = item.itemIdentifier {
                identifiers.append(id)
            }
        }
        auth.photoAssetIdentifiers = identifiers
    }

    private func handleSignup() {
        auth.signup()
    }
} 