import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: UserProfile? = nil

    // Login fields
    @Published var loginUsername: String = ""
    @Published var loginPassword: String = ""
    @Published var loginError: String? = nil

    // Signup fields
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var bio: String = ""
    @Published var gymLocation: String = ""
    @Published var trainingSplit: String = ""
    @Published var gymLevel: String = "Beginner"
    @Published var photoAssetIdentifiers: [String] = []

    private let storageKey = "auth.currentUser"
    private let credentialsKey = "auth.credentials" // map username -> password

    init() {
        load()
    }

    func login() {
        loginError = nil
        let trimmedUser = loginUsername.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedUser.isEmpty, !loginPassword.isEmpty else {
            loginError = "Enter username and password"
            return
        }
        let creds = UserDefaults.standard.dictionary(forKey: credentialsKey) as? [String: String] ?? [:]
        guard let storedPass = creds[trimmedUser], storedPass == loginPassword else {
            loginError = "Invalid username or password"
            return
        }
        // If we have a stored profile, use it; otherwise create a minimal one
        if let data = UserDefaults.standard.data(forKey: storageKey), let profile = try? JSONDecoder().decode(UserProfile.self, from: data), profile.username == trimmedUser {
            currentUser = profile
        } else {
            currentUser = UserProfile(name: trimmedUser, username: trimmedUser, gymLocation: "", trainingSplit: "", gymLevel: gymLevel)
            save()
        }
        isAuthenticated = true
    }

    func signup() {
        // Validation
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let trimmedUser = username.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedUser.isEmpty else { return }
        guard password.count >= 6 else { return }
        guard password == confirmPassword else { return }

        var creds = UserDefaults.standard.dictionary(forKey: credentialsKey) as? [String: String] ?? [:]
        // prevent duplicate usernames
        guard creds[trimmedUser] == nil else { return }
        creds[trimmedUser] = password
        UserDefaults.standard.set(creds, forKey: credentialsKey)

        let profile = UserProfile(name: name, username: trimmedUser, bio: bio.isEmpty ? nil : bio, gymLocation: gymLocation, trainingSplit: trainingSplit, gymLevel: gymLevel, photoAssetIdentifiers: photoAssetIdentifiers)
        currentUser = profile
        isAuthenticated = true
        save()
        // Reset signup fields
        name = ""; username = ""; password = ""; confirmPassword = ""; bio = ""; gymLocation = ""; trainingSplit = ""; photoAssetIdentifiers = []
    }

    func logout() {
        isAuthenticated = false
    }

    private func save() {
        guard let user = currentUser, let data = try? JSONEncoder().encode(user) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: storageKey), let profile = try? JSONDecoder().decode(UserProfile.self, from: data) {
            currentUser = profile
            isAuthenticated = true
        }
    }
} 