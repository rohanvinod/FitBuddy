import Foundation
import Combine
import UIKit

final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: UserProfile? = nil

    // Login fields
    @Published var loginEmail: String = ""
    @Published var loginUsername: String = ""
    @Published var loginPassword: String = ""
    @Published var loginError: String? = nil
    @Published var rememberMe: Bool = true // Default to true for better UX

    // Signup fields
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var bio: String = ""
    @Published var gymLocation: String = ""
    @Published var trainingSplit: String = ""
    @Published var gymLevel: String = "Beginner"
    @Published var photoAssetIdentifiers: [String] = []
    @Published var photoImageData: [Data] = [] // Store actual image data

    private let storageKey = "auth.currentUser"
    private let credentialsKey = "auth.credentials" // map username -> password
    private let autoLoginKey = "auth.autoLoginEnabled"

    init() {
        load()
        // Migrate existing profiles to include photoImageData if needed
        migrateExistingProfiles()
        // Auto-login at startup if credentials exist and auto-login is enabled
        if autoLoginEnabled {
            autoLogin()
        }
    }
    
    // Migrate existing profiles to include photoImageData
    private func migrateExistingProfiles() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let profile = try? JSONDecoder().decode(UserProfile.self, from: data) {
            // Check if this is an old profile without photoImageData
            if profile.photoImageData.isEmpty {
                var updatedProfile = profile
                updatedProfile.photoImageData = []
                currentUser = updatedProfile
                save()
            }
        }
    }

    // Auto-login method that attempts to log in with stored credentials
    func autoLogin() {
        guard !isAuthenticated && autoLoginEnabled else { return } // Don't auto-login if already authenticated or disabled
        
        // Check if we have stored user data
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let profile = try? JSONDecoder().decode(UserProfile.self, from: data) {
            
            // Check if we have stored credentials for this user
            let creds = UserDefaults.standard.dictionary(forKey: credentialsKey) as? [String: String] ?? [:]
            if let storedPassword = creds[profile.username] {
                // Auto-login with stored credentials
                loginUsername = profile.username
                loginPassword = storedPassword
                
                // Set the current user and authenticate
                currentUser = profile
                isAuthenticated = true
                
                // Clear the stored password from memory for security
                loginPassword = ""
            }
        }
    }
    
    // Public method to manually trigger auto-login
    func triggerAutoLogin() {
        if autoLoginEnabled && hasStoredCredentials {
            autoLogin()
        }
    }

    // Computed property for auto-login preference
    var autoLoginEnabled: Bool {
        get {
            UserDefaults.standard.object(forKey: autoLoginKey) as? Bool ?? true // Default to true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: autoLoginKey)
        }
    }
    
    // Check if auto-login credentials exist
    var hasStoredCredentials: Bool {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let profile = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            return false
        }
        
        let creds = UserDefaults.standard.dictionary(forKey: credentialsKey) as? [String: String] ?? [:]
        return creds[profile.username] != nil
    }
    
    // Get current user's profile images
    var currentUserImages: [UIImage] {
        guard let user = currentUser else { return [] }
        
        var images: [UIImage] = []
        for imageData in user.photoImageData {
            if let uiImage = UIImage(data: imageData) {
                images.append(uiImage)
            }
        }
        return images
    }
    
    // Check if user has profile photos
    var hasProfilePhotos: Bool {
        return !currentUserImages.isEmpty
    }

    func login() {
        loginError = nil
        
        // Check if user provided email or username
        let identifier = !loginEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 
                        loginEmail.trimmingCharacters(in: .whitespacesAndNewlines) : 
                        loginUsername.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !identifier.isEmpty, !loginPassword.isEmpty else {
            loginError = "Enter email/username and password"
            return
        }
        
        let creds = UserDefaults.standard.dictionary(forKey: credentialsKey) as? [String: String] ?? [:]
        
        // Try to find user by email or username
        var foundUser: String? = nil
        
        // First, check if the identifier is an email and find the corresponding username
        if identifier.contains("@") {
            // Search for user by email in stored profiles
            if let data = UserDefaults.standard.data(forKey: storageKey),
               let profile = try? JSONDecoder().decode(UserProfile.self, from: data),
               profile.email.lowercased() == identifier.lowercased() {
                foundUser = profile.username
            }
        } else {
            // Identifier is a username
            foundUser = identifier
        }
        
        guard let username = foundUser,
              let storedPass = creds[username],
              storedPass == loginPassword else {
            loginError = "Invalid email/username or password"
            return
        }
        
        // If we have a stored profile, use it; otherwise create a minimal one
        if let data = UserDefaults.standard.data(forKey: storageKey), let profile = try? JSONDecoder().decode(UserProfile.self, from: data), profile.username == username {
            currentUser = profile
            // Update existing profile to include photoImageData if it doesn't exist
            if profile.photoImageData.isEmpty {
                updateProfileWithImageData(profile)
            }
        } else {
            currentUser = UserProfile(name: username, username: username, gymLocation: "", trainingSplit: "", gymLevel: gymLevel)
            save()
        }
        
        // Store credentials only if rememberMe is true
        if rememberMe {
            var updatedCreds = creds
            updatedCreds[username] = loginPassword
            UserDefaults.standard.set(updatedCreds, forKey: credentialsKey)
        }
        
        isAuthenticated = true
        
        // Clear sensitive data from memory
        loginPassword = ""
        loginEmail = ""
        loginUsername = ""
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

        let profile = UserProfile(name: name, username: trimmedUser, email: email, bio: bio.isEmpty ? nil : bio, gymLocation: gymLocation, trainingSplit: trainingSplit, gymLevel: gymLevel, photoAssetIdentifiers: photoAssetIdentifiers, photoImageData: photoImageData)
        currentUser = profile
        isAuthenticated = true
        save()
        // Reset signup fields
        name = ""; username = ""; email = ""; password = ""; confirmPassword = ""; bio = ""; gymLocation = ""; trainingSplit = ""; photoAssetIdentifiers = []; photoImageData = []
    }

    func logout() {
        // Store username before clearing currentUser
        let username = currentUser?.username
        
        isAuthenticated = false
        currentUser = nil
        
        // Clear stored credentials for security
        if let username = username {
            var creds = UserDefaults.standard.dictionary(forKey: credentialsKey) as? [String: String] ?? [:]
            creds.removeValue(forKey: username)
            UserDefaults.standard.set(creds, forKey: credentialsKey)
        }
        
        // Clear stored user data
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
    
    // Method to clear all stored data (useful for account deletion)
    func clearAllData() {
        UserDefaults.standard.removeObject(forKey: storageKey)
        UserDefaults.standard.removeObject(forKey: credentialsKey)
        UserDefaults.standard.removeObject(forKey: autoLoginKey)
        
        isAuthenticated = false
        currentUser = nil
        loginUsername = ""
        loginPassword = ""
        rememberMe = true
        photoImageData = []
        photoAssetIdentifiers = []
    }
    
    // Method to update existing profile with image data
    private func updateProfileWithImageData(_ profile: UserProfile) {
        var updatedProfile = profile
        updatedProfile.photoImageData = [] // Initialize with empty array for existing profiles
        currentUser = updatedProfile
        save()
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