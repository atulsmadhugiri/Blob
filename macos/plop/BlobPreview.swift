import SwiftUI

struct BlobPreview: View {
  var previousUploadURL: String
  var previousUploadLocalPath: URL?

  var body: some View {
    AsyncImage(url: URL(string: previousUploadURL)) { image in
      image.resizable().scaledToFit().cornerRadius(8).frame(width: 300, height: 200).id(
        previousUploadURL
      ).transition(.opacity.animation(.default)).onDrag {
        if let previousUploadLocalPath = previousUploadLocalPath {
          let temporaryPath = URL(
            fileURLWithPath:
              "\(NSTemporaryDirectory())onDrag/\(previousUploadLocalPath.lastPathComponent)")
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
    BlobPreview(previousUploadURL: "https://blob.sh/dabff5.png")
  }
}
