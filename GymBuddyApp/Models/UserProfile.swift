import Foundation
import SwiftUI

struct UserProfile: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var gymLocation: String
    var trainingSplit: String
    var gymLevel: String
    var photoAssetIdentifiers: [String]

    init(id: UUID = UUID(), name: String, gymLocation: String, trainingSplit: String, gymLevel: String, photoAssetIdentifiers: [String] = []) {
        self.id = id
        self.name = name
        self.gymLocation = gymLocation
        self.trainingSplit = trainingSplit
        self.gymLevel = gymLevel
        self.photoAssetIdentifiers = photoAssetIdentifiers
    }
} 