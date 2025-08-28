import SwiftUI

struct SafeImageView: View {
    let imageName: String
    let placeholderSymbol: String

    init(imageName: String, placeholderSymbol: String = "photo.fill") {
        self.imageName = imageName
        self.placeholderSymbol = placeholderSymbol
    }

    var body: some View {
        if let uiImage = UIImage(named: imageName) {
            Image(uiImage: uiImage)
                .resizable()
        } else {
            Image(systemName: placeholderSymbol)
                .resizable()
                .scaledToFit()
                .foregroundColor(.secondary)
                .padding()
                .background(Color.coffeeBackground)
        }
    }
}

struct SafeImageView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            SafeImageView(imageName: "existing_image_placeholder") // This will show the placeholder
                .frame(width: 100, height: 100)
                .cornerRadius(10)

            SafeImageView(imageName: "gym1", placeholderSymbol: "figure.strengthtraining.traditional") // Assuming 'gym1' doesn't exist
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
    }
}
