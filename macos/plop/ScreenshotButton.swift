import SwiftUI

struct ScreenshotButton: View {
  @ObservedObject var blobGlobalState: BlobGlobalState
  @Binding var uploadProgress: Double

  var body: some View {
    Button(action: {
      let filepath = captureScreenshot()
      let (destinationURL, uploadTask, localPath) = uploadBlob(filepath: filepath)

      uploadTask.observe(.progress) { snapshot in
        uploadProgress = snapshot.progress?.fractionCompleted ?? 0
      }
      uploadTask.observe(.success) { _ in
        NSSound(named: "Funk")?.play()
        replaceClipboard(with: destinationURL)
        let blobEntry = BlobEntry()
        blobEntry.uploadURL = destinationURL
        blobEntry.uploadLocalPath = localPath
        blobEntry.fileSize = getFormattedFileSize(fromURL: localPath)
        blobEntry.mimeType = getMIMEType(fromURL: localPath)
        blobGlobalState.blobEntries.append(blobEntry)
      }
    }) {
      Text("Screenshot (")
      Image(systemName: "command")
      Image(systemName: "shift")
      Text("Z )")
    }
  }
}

struct ScreenshotButton_Previews: PreviewProvider {
  static var previews: some View {
    ScreenshotButton(
      blobGlobalState: BlobGlobalState(),
      uploadProgress: .constant(1.0))
  }
}
