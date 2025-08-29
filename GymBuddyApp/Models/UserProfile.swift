import Foundation
import SwiftUI

struct UserProfile: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var username: String
    var email: String
    var bio: String?
    var gymLocation: String
    var trainingSplit: String
    var gymLevel: String
    var photoAssetIdentifiers: [String]
    var photoImageData: [Data] // Store actual image data

    init(id: UUID = UUID(), name: String, username: String, email: String = "", bio: String? = nil, gymLocation: String, trainingSplit: String, gymLevel: String, photoAssetIdentifiers: [String] = [], photoImageData: [Data] = []) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.bio = bio
        self.gymLocation = gymLocation
        self.trainingSplit = trainingSplit
        self.gymLevel = gymLevel
        self.photoAssetIdentifiers = photoAssetIdentifiers
        self.photoImageData = photoImageData
    }
} 