
import Coffee_Kit
import SwiftUI
import UIKit

struct ProductImageView: View {
    @Environment(ImageManager.self) private var imageManager
    @Binding var product: Product
    @State private var imageData = Data()
    let frameSize: CGFloat

    var body: some View {
        VStack {
            if let uIImage = UIImage(data: imageData) {
                Image(uiImage: uIImage)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: frameSize, minHeight: frameSize)
                    .cornerRadius(8)
                    .shadow(radius: 1.0)

            } else {
                ProgressView()
                    .scaledToFit()
                    .frame(minWidth: frameSize, minHeight: frameSize)
            }
        }
        .task(priority: .userInitiated) {
            imageData = await imageManager.fetchImageData(for: product)
        }
    }
}
