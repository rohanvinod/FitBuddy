import SwiftUI
import PhotosUI

struct SignupView: View {
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var thumbnails: [Image] = []
    @State private var showPassword: Bool = false
    @State private var showConfirm: Bool = false

    let gymLevels = ["Beginner", "Intermediate", "Advanced"]
    let splits = ["Arnold", "Upper/Lower", "PPL", "Full Body", "Custom"]

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.coffeeGradientStart, Color.coffeeGradientEnd]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header section
                    VStack(spacing: 20) {
                        // Decorative image placeholder
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.coffeeCard.opacity(0.1))
                                .frame(width: 120, height: 120)
                            
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 50))
                                .foregroundColor(.coffeeCard)
                        }
                        .padding(.top, 40)
                        
                        VStack(spacing: 8) {
                            Text("Create Account")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.coffeeCard)
                            
                            Text("Join the fitness community and find your perfect gym partner")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.coffeeCard.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.bottom, 30)
                    
                    // Signup form card
                    VStack(spacing: 0) {
                        VStack(spacing: 24) {
                            // Personal Information Section
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Personal Information")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.coffeeText)
                                
                                VStack(spacing: 16) {
                                    LabeledField(icon: "person.fill", placeholder: "Full name", text: $auth.name)
                                    LabeledField(icon: "envelope.fill", placeholder: "Email address", text: $auth.email)
                                    LabeledField(icon: "at", placeholder: "Username", text: $auth.username)
                                    LabeledTextEditor(icon: "text.justify", placeholder: "Bio (optional)", text: $auth.bio)
                                }
                            }
                            
                            // Fitness Information Section
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Fitness Profile")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.coffeeText)
                                
                                VStack(spacing: 16) {
                                    LabeledField(icon: "building.2.fill", placeholder: "Gym membership location", text: $auth.gymLocation)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Training split")
                                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                                            .foregroundColor(.coffeeText)
                                        
                                        Picker("Training split", selection: $auth.trainingSplit) {
                                            ForEach(splits, id: \.self) { split in
                                                Text(split).tag(split)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .padding()
                                        .background(Color.coffeeBackground)
                                        .cornerRadius(16)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
                                        )
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Experience level")
                                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                                            .foregroundColor(.coffeeText)
                                        
                                        Picker("Experience level", selection: $auth.gymLevel) {
                                            ForEach(gymLevels, id: \.self) { level in
                                                Text(level).tag(level)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .padding()
                                        .background(Color.coffeeBackground)
                                        .cornerRadius(16)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
                                        )
                                    }
                                }
                            }
                            
                            // Profile Photos Section
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Profile Photos")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.coffeeText)
                                
                                VStack(spacing: 16) {
                                    Text("Add up to 5 photos to showcase your fitness journey")
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.coffeeTextSecondary)
                                    
                                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 5, matching: .images) {
                                        HStack {
                                            Image(systemName: "photo.on.rectangle.angled")
                                                .font(.system(size: 18))
                                            Text("Select Photos")
                                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                            Spacer()
                                        }
                                        .foregroundColor(.coffeePrimary)
                                        .padding()
                                        .background(Color.coffeeBackground)
                                        .cornerRadius(16)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(Color.coffeePrimary.opacity(0.3), lineWidth: 2)
                                        )
                                    }
                                    .onChange(of: selectedItems) { items in
                                        Task {
                                            await loadAssets(from: items)
                                        }
                                    }
                                    
                                    if !thumbnails.isEmpty {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 12) {
                                                ForEach(thumbnails.indices, id: \.self) { idx in
                                                    thumbnails[idx]
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 80, height: 80)
                                                        .clipped()
                                                        .cornerRadius(16)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
                                                        )
                                                }
                                            }
                                            .padding(.horizontal, 4)
                                        }
                                    }
                                }
                            }
                            
                            // Security Section
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Security")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.coffeeText)
                                
                                VStack(spacing: 16) {
                                    PasswordRow(placeholder: "Password", text: $auth.password, show: $showPassword)
                                    PasswordRow(placeholder: "Confirm password", text: $auth.confirmPassword, show: $showConfirm)
                                    
                                    if !passwordsValid && !auth.password.isEmpty {
                                        HStack {
                                            Image(systemName: "exclamationmark.triangle.fill")
                                                .foregroundColor(.coffeeWarning)
                                            Text(passwordValidationMessage)
                                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                                .foregroundColor(.coffeeWarning)
                                        }
                                        .padding()
                                        .background(Color.coffeeWarning.opacity(0.1))
                                        .cornerRadius(12)
                                    }
                                }
                            }
                            
                            // Create Account Button
                            Button(action: handleSignup) {
                                HStack {
                                    Text("Create Account")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(.coffeeCard)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(
                                    AnyShapeStyle(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.coffeePrimary, Color.coffeeSecondary]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(color: .coffeeShadowStrong, radius: 8, x: 0, y: 4)
                            }
                            .disabled(!formValid)
                            .opacity(formValid ? 1 : 0.6)
                            
                            // Sign in link
                            HStack(spacing: 4) {
                                Text("Already have an account?")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.coffeeTextSecondary)
                                
                                Button("Sign In") {
                                    dismiss()
                                }
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundColor(.coffeePrimary)
                            }
                            .padding(.top, 8)
                        }
                        .padding(32)
                    }
                    .background(Color.coffeeCard)
                    .cornerRadius(35)
                    .shadow(color: Color.coffeeShadowStrong, radius: 20, x: 0, y: 10)
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private var formValid: Bool {
        !auth.name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !auth.email.trimmingCharacters(in: .whitespaces).isEmpty &&
        !auth.username.trimmingCharacters(in: .whitespaces).isEmpty &&
        !auth.gymLocation.trimmingCharacters(in: .whitespaces).isEmpty &&
        passwordsValid
    }

    private var passwordsValid: Bool {
        !auth.password.isEmpty && auth.password == auth.confirmPassword && auth.password.count >= 6
    }

    private var passwordValidationMessage: String {
        passwordsValid ? "Passwords match" : "Passwords must match and be at least 6 characters"
    }

    private func loadAssets(from items: [PhotosPickerItem]) async {
        thumbnails.removeAll()
        var identifiers: [String] = []
        var imageData: [Data] = []
        
        for item in items {
            if let id = item.itemIdentifier { 
                identifiers.append(id) 
            }
            if let data = try? await item.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                thumbnails.append(Image(uiImage: uiImage))
                imageData.append(data) // Store the actual image data
            }
        }
        
        auth.photoAssetIdentifiers = identifiers
        auth.photoImageData = imageData
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
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.coffeePrimary)
                    .frame(width: 20)
                TextField(placeholder, text: $text)
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.coffeeText)
            }
            .padding()
            .background(Color.coffeeBackground)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

private struct LabeledTextEditor: View {
    let icon: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack { 
                Image(systemName: icon)
                    .foregroundColor(.coffeePrimary)
                    .frame(width: 20)
                Text(placeholder)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.coffeeTextSecondary)
            }
            TextEditor(text: $text)
                .frame(minHeight: 80)
                .padding(12)
                .background(Color.coffeeBackground)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
                )
                .font(.system(size: 16, design: .rounded))
                .foregroundColor(.coffeeText)
        }
    }
}

private struct PasswordRow: View {
    let placeholder: String
    @Binding var text: String
    @Binding var show: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(.coffeePrimary)
                    .frame(width: 20)
                
                if show {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.coffeeText)
                } else {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.coffeeText)
                }
                
                Button(action: { show.toggle() }) {
                    Image(systemName: show ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.coffeePrimary)
                        .font(.system(size: 16))
                }
            }
            .padding()
            .background(Color.coffeeBackground)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.coffeePrimary.opacity(0.2), lineWidth: 1)
            )
        }
    }
} 