import SwiftUI

struct ScreenshotButton: View {
  @Binding var previousUploadURL: String
  @Binding var uploadProgress: Double

  var body: some View {
    Button(action: {
      let filepath = captureScreenshot()
      let retval = uploadBlob(filepath: filepath)

      previousUploadURL = retval.endpoint
      retval.uploadTask.observe(.progress) { snapshot in
        uploadProgress = snapshot.progress?.fractionCompleted ?? 0
      }
    }) {
      if #available(macOS 11.0, *) {
        Text("Screenshot (")
        Image(systemName: "command")
        Image(systemName: "shift")
        Text("Z )")
      } else {
        Text("Screenshot (CMD-SHIFT-Z)")
      }
    }
  }
}

struct ScreenshotButton_Previews: PreviewProvider {
  static var previews: some View {
    ScreenshotButton(previousUploadURL: .constant("https://google.com"), uploadProgress: .constant(1.0))
  }
}
