import SwiftUI

extension Color {
    // Primary brand colors - warm, coffee-inspired palette
    static let coffeePrimary = Color(red: 0.4, green: 0.25, blue: 0.15) // Rich dark brown
    static let coffeeSecondary = Color(red: 0.6, green: 0.45, blue: 0.3) // Medium brown
    static let coffeeAccent = Color(red: 0.8, green: 0.2, blue: 0.2) // Warm red accent
    
    // Background colors - warm, neutral tones
    static let coffeeBackground = Color(red: 0.98, green: 0.96, blue: 0.94) // Warm off-white
    static let coffeeSurface = Color(red: 0.95, green: 0.93, blue: 0.91) // Light surface
    static let coffeeCard = Color(red: 1.0, green: 0.98, blue: 0.96) // Pure white cards
    
    // Text colors - high contrast for readability
    static let coffeeText = Color(red: 0.15, green: 0.1, blue: 0.05) // Dark brown text
    static let coffeeTextSecondary = Color(red: 0.4, green: 0.35, blue: 0.3) // Medium brown text
    static let coffeeTextLight = Color(red: 0.6, green: 0.55, blue: 0.5) // Light brown text
    
    // Status colors
    static let coffeeSuccess = Color(red: 0.2, green: 0.6, blue: 0.3) // Green success
    static let coffeeWarning = Color(red: 0.9, green: 0.6, blue: 0.1) // Orange warning
    static let coffeeError = Color(red: 0.8, green: 0.2, blue: 0.2) // Red error
    
    // Gradient colors
    static let coffeeGradientStart = Color(red: 0.4, green: 0.25, blue: 0.15)
    static let coffeeGradientEnd = Color(red: 0.6, green: 0.4, blue: 0.25)
    
    // Shadow colors
    static let coffeeShadow = Color.black.opacity(0.08)
    static let coffeeShadowStrong = Color.black.opacity(0.15)
}
