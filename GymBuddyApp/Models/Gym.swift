import Foundation
import CoreLocation

struct Gym: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let address: String
    let hours: [String]
    let facilities: [String]
    let imageName: String

    // Conform to Hashable
    static func == (lhs: Gym, rhs: Gym) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
