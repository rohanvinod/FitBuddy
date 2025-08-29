import Combine
import SwiftUI

class CardStackViewModel: ObservableObject {
    @Published var userProfiles: [UserProfile] = []

    init() {
        // Create sample user profiles based on the signup form fields
        // In a real app, this would come from a backend service
        self.userProfiles = createSampleProfiles()
    }

    func removeCard() {
        if !userProfiles.isEmpty {
            userProfiles.removeLast()
        }
    }
    
    private func createSampleProfiles() -> [UserProfile] {
        return [
            UserProfile(
                name: "Alex Chen",
                username: "alexchen",
                email: "alex.chen@email.com",
                bio: "Looking for a consistent gym partner for morning workouts. I'm into strength training and love pushing each other to new PRs!",
                gymLocation: "City Sports Club, San Ramon",
                trainingSplit: "PPL",
                gymLevel: "Intermediate",
                photoAssetIdentifiers: [],
                photoImageData: []
            ),
            UserProfile(
                name: "Jessica Rodriguez",
                username: "jessrodriguez",
                email: "jess.rodriguez@email.com",
                bio: "CrossFit enthusiast who loves high-intensity workouts. Looking for someone to join me for weekend WODs and keep me motivated!",
                gymLocation: "24 Hour Fitness, Dublin",
                trainingSplit: "Upper/Lower",
                gymLevel: "Advanced",
                photoAssetIdentifiers: [],
                photoImageData: []
            ),
            UserProfile(
                name: "Chris Thompson",
                username: "christhompson",
                email: "chris.thompson@email.com",
                bio: "Serious about powerlifting and bodybuilding. Let's hit some PRs together and build strength! Always looking for a spotter.",
                gymLocation: "The Club at Livermore",
                trainingSplit: "Arnold",
                gymLevel: "Advanced",
                photoAssetIdentifiers: [],
                photoImageData: []
            ),
            UserProfile(
                name: "Sam Wilson",
                username: "samwilson",
                email: "sam.wilson@email.com",
                bio: "Into mindful movement and finding balance. Join me for yoga sessions and let's create a peaceful workout environment together.",
                gymLocation: "City Sports Club, San Ramon",
                trainingSplit: "Full Body",
                gymLevel: "Beginner",
                photoAssetIdentifiers: [],
                photoImageData: []
            ),
            UserProfile(
                name: "Maya Patel",
                username: "mayapatel",
                email: "maya.patel@email.com",
                bio: "Fitness is my passion! I love trying new workouts and staying active. Looking for a gym buddy to explore different training styles with.",
                gymLocation: "24 Hour Fitness, Dublin",
                trainingSplit: "Custom",
                gymLevel: "Intermediate",
                photoAssetIdentifiers: [],
                photoImageData: []
            )
        ].reversed()
    }
}
