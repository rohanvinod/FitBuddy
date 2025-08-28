import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: UserProfile? = nil

    // Signup fields
    @Published var name: String = ""
    @Published var gymLocation: String = ""
    @Published var trainingSplit: String = ""
    @Published var gymLevel: String = "Beginner"
    @Published var photoAssetIdentifiers: [String] = []

    private let storageKey = "auth.currentUser"

    init() {
        load()
    }

    func login(name: String) {
        // For demo: if a stored profile exists and name matches, log in; else create a lightweight session
        if let stored = currentUser, stored.name.caseInsensitiveCompare(name) == .orderedSame {
            isAuthenticated = true
            return
        }
        // fallback temporary session
        currentUser = UserProfile(name: name, gymLocation: "", trainingSplit: "", gymLevel: gymLevel)
        isAuthenticated = true
        save()
    }

    func signup() {
        let profile = UserProfile(name: name, gymLocation: gymLocation, trainingSplit: trainingSplit, gymLevel: gymLevel, photoAssetIdentifiers: photoAssetIdentifiers)
        currentUser = profile
        isAuthenticated = true
        save()
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