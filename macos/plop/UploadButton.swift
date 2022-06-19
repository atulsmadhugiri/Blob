import SwiftUI

struct UploadButton: View {
  @Binding var previousUploadURL: String
  @Binding var uploadProgress: Double

  var body: some View {
    Button(action: {
      let fileSelectionDialog = NSOpenPanel()
      let fileSelectionResponse = fileSelectionDialog.runModal()

      if fileSelectionResponse == NSApplication.ModalResponse.OK {
        let (destinationURL, uploadTask) = uploadBlob(
          filepath: fileSelectionDialog.url!.path)

        previousUploadURL = destinationURL
        uploadTask.observe(.progress) { snapshot in
          uploadProgress = snapshot.progress?.fractionCompleted ?? 0
        }
        uploadTask.observe(.success) { _ in
          NSSound(named: "Funk")?.play()
          replaceClipboard(with: destinationURL)
        }
      }
    }) {
      Text("Upload (")
      Image(systemName: "command")
      Image(systemName: "shift")
      Text("U )")
    }
  }
}

struct UploadButton_Previews: PreviewProvider {
  static var previews: some View {
    UploadButton(previousUploadURL: .constant("https://google.com"), uploadProgress: .constant(1.0))
  }
}
