import SwiftUI

struct BlobPopover: View {
  @State private var uploadProgress: Double = 1.0
  @State private var previousUploadURL: String = ""
  @State private var previousUploadLocalPath: URL?
  @State private var anonymousUploadsEnabled: Bool = false

  var body: some View {
    VStack {
      HStack {
        ScreenshotButton(
          previousUploadURL: $previousUploadURL, previousUploadLocalPath: $previousUploadLocalPath,
          uploadProgress: $uploadProgress)
        UploadButton(previousUploadURL: $previousUploadURL, uploadProgress: $uploadProgress)
      }

      UploadProgressView(uploadProgress: uploadProgress)

      HStack {
        TextField("", text: $previousUploadURL).frame(width: 208)
        CopyButton(previousUploadURL: previousUploadURL)
        OpenButton(previousUploadURL: previousUploadURL)
      }

      Divider()

      AsyncImage(url: URL(string: previousUploadURL)) { image in
        image.resizable().scaledToFit().cornerRadius(8).frame(width: 300, height: 200).onDrag {
          if let previousUploadLocalPath = previousUploadLocalPath {
            let temporaryPath = URL(fileURLWithPath: "\(NSTemporaryDirectory())onDrag/\(previousUploadLocalPath.lastPathComponent)")
            do {
              try FileManager().createDirectory(at: temporaryPath.deletingLastPathComponent(), withIntermediateDirectories: true)
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
    }.padding(.all, 10).padding(.top, 10)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover()
  }
}
