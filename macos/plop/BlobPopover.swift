import SwiftUI

struct BlobPopover: View {
  @State private var uploadProgress: Double = 1.0
  @State private var previousUploadURL: String = ""
  @State private var anonymousUploadsEnabled: Bool = false

  var body: some View {
    VStack {
      HStack {
        ScreenshotButton(previousUploadURL: $previousUploadURL, uploadProgress: $uploadProgress)
        Button(action: {}) { UploadButton() }
      }

      if #available(macOS 11.0, *) {
        ProgressView("", value: uploadProgress, total: 1.0).padding(.horizontal, 20)
      }

      HStack {
        TextField("", text: $previousUploadURL).frame(width: 208)
        CopyButton(previousUploadURL: previousUploadURL)
        OpenButton(previousUploadURL: previousUploadURL)
      }
    }.padding(.all, 20)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover()
  }
}
