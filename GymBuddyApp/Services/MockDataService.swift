import Foundation
import CoreLocation

struct MockDataService {

    static let users: [User] = [
        User(name: "Alex", age: 25, profileImageName: "alex", interests: ["Weightlifting", "Yoga"], bio: "Looking for a consistent gym partner for morning workouts."),
        User(name: "Jess", age: 22, profileImageName: "jess", interests: ["CrossFit", "Running"], bio: "I love high-intensity workouts and running on weekends."),
        User(name: "Chris", age: 30, profileImageName: "chris", interests: ["Powerlifting", "Bodybuilding"], bio: "Serious about lifting. Let's hit some PRs together."),
        User(name: "Sam", age: 27, profileImageName: "sam", interests: ["Yoga", "Pilates", "Meditation"], bio: "Into mindful movement and finding balance. Join me for a yoga session!")
    ]

    static let gyms: [Gym] = [
        Gym(name: "City Sports Club, San Ramon", 
            coordinate: CLLocationCoordinate2D(latitude: 37.7699, longitude: -121.9618), 
            address: "200 Montgomery St, San Ramon, CA 94583",
            hours: ["Mon-Fri: 5am - 10pm", "Sat-Sun: 7am - 8pm"],
            facilities: ["Basketball", "Pool", "Cardio Machines", "Free Weights", "Group Classes"], 
            imageName: "gym1"),
        Gym(name: "24 Hour Fitness, Dublin", 
            coordinate: CLLocationCoordinate2D(latitude: 37.7099, longitude: -121.8942), 
            address: "4288 Dublin Blvd, Dublin, CA 94568",
            hours: ["Open 24 hours"],
            facilities: ["Weightlifting", "Cardio", "Sauna", "Steam Room", "Personal Training"], 
            imageName: "gym2"),
        Gym(name: "The Club at Livermore", 
            coordinate: CLLocationCoordinate2D(latitude: 37.6819, longitude: -121.7680), 
            address: "2000 Arroyo Rd, Livermore, CA 94550",
            hours: ["Mon-Sun: 6am - 9pm"],
            facilities: ["Tennis Courts", "Group Fitness", "Yoga Studio", "Swimming Pool", "Cafe"], 
            imageName: "gym3")
    ]

    static let messages: [ChatMessage] = [
        ChatMessage(message: "Hey! Saw we matched. I'm also into weightlifting.", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-3600)),
        ChatMessage(message: "Awesome! When do you usually work out?", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-3540)),
        ChatMessage(message: "Usually in the mornings around 7 AM.", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-3480)),
        ChatMessage(message: "Perfect, me too. Let's plan something for next week?", isFromCurrentUser: true, timestamp: Date().addingTimeInterval(-3420))
    ]
}
