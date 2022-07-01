import SwiftUI

struct BlobPopover: View {
  @State private var uploadProgress: Double = 1.0
  @State private var previousUploadURL: String = ""
  @State private var previousUploadLocalPath: URL?
  @State private var anonymousUploadsEnabled: Bool = false
  @State private var recognizedText: String?

  var body: some View {
    VStack {
      HStack {
        ScreenshotButton(
          previousUploadURL: $previousUploadURL, previousUploadLocalPath: $previousUploadLocalPath,
          uploadProgress: $uploadProgress, recognizedText: $recognizedText)
        UploadButton(previousUploadURL: $previousUploadURL, uploadProgress: $uploadProgress)
      }

      UploadProgressView(uploadProgress: uploadProgress)

      HStack {
        TextField("", text: $previousUploadURL).frame(width: 208)
        CopyButton(previousUploadURL: previousUploadURL)
        OpenButton(previousUploadURL: previousUploadURL)
      }

      Divider()

      BlobPreview(previousUploadLocalPath: previousUploadLocalPath)

      Divider()

      Text(recognizedText ?? "").fixedSize(horizontal: false, vertical: true).lineLimit(4)

    }.padding(.all, 10).padding(.top, 10)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover()
  }
}
