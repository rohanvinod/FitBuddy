import Foundation

struct User: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let age: Int
    let profileImageName: String
    let interests: [String]
    let bio: String
}
