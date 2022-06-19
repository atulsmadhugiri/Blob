import SwiftUI

struct UploadButton: View {
  @Binding var previousUploadURL: String
  @Binding var uploadProgress: Double

  @State private var fileSelectionDialogPresented = false

  var body: some View {
    Button(action: {
      fileSelectionDialogPresented = true
    }) {
      Text("Upload (")
      Image(systemName: "command")
      Image(systemName: "shift")
      Text("U )")
    }.fileImporter(
      isPresented: $fileSelectionDialogPresented,
      allowedContentTypes: [.image, .audio, .video, .text, .data]
    ) { result in
      do {
        let filepath = try result.get().path
        let (destinationURL, uploadTask) = uploadBlob(filepath: filepath)
        previousUploadURL = destinationURL

        uploadTask.observe(.progress) { snapshot in
          uploadProgress = snapshot.progress?.fractionCompleted ?? 0
        }
        uploadTask.observe(.success) { _ in
          NSSound(named: "Funk")?.play()
          replaceClipboard(with: destinationURL)
        }
      } catch {
        print("Could not get filepath for selected file.")
      }
    }
  }
}

struct UploadButton_Previews: PreviewProvider {
  static var previews: some View {
    UploadButton(previousUploadURL: .constant("https://google.com"), uploadProgress: .constant(1.0))
  }
}
