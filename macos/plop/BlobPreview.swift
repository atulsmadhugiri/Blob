import SwiftUI

struct BlobPreview: View {
  var previousUploadLocalPath: URL?
  var width: CGFloat = 300
  var height: CGFloat = 200

  var body: some View {
    AsyncImage(url: previousUploadLocalPath) { image in
      image.interpolation(.none).resizable().scaledToFit().cornerRadius(8).frame(
        width: width, height: height
      ).id(
        previousUploadLocalPath
      ).transition(.opacity.animation(.default)).onDrag {
        if let previousUploadLocalPath {
          let temporaryPathString =
            "\(NSTemporaryDirectory())onDrag/\(previousUploadLocalPath.lastPathComponent)"
          let temporaryPath = URL(fileURLWithPath: temporaryPathString)
          if FileManager().fileExists(atPath: temporaryPathString) {
            if let provider = NSItemProvider(contentsOf: temporaryPath) {
              provider.suggestedName = previousUploadLocalPath.lastPathComponent
              return provider
            }
          }
          do {
            try FileManager().createDirectory(
              at: temporaryPath.deletingLastPathComponent(), withIntermediateDirectories: true)
            try FileManager().copyItem(at: previousUploadLocalPath, to: temporaryPath)
            if let provider = NSItemProvider(contentsOf: temporaryPath) {
              provider.suggestedName = previousUploadLocalPath.lastPathComponent
              return provider
            }
          } catch {
            print("Error creating temporary file in .onDrag")
          }
        }
        return NSItemProvider()
      }
    } placeholder: {
      Color.gray.opacity(0.1).cornerRadius(8)
    }
  }
}

struct BlobPreview_Previews: PreviewProvider {
  static var previews: some View {
    BlobPreview(previousUploadLocalPath: nil)
  }
}
