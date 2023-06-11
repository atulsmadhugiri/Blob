import SwiftUI

struct ScreenshotButton: View {
  @Bindable var blobGlobalState: BlobGlobalState
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
        let blobEntry = BlobEntry(
          uploadProgress: 1.0,
          uploadURL: destinationURL,
          uploadLocalPath: localPath,
          fileSize: getFormattedFileSize(fromURL: localPath),
          mimeType: getMIMEType(fromURL: localPath),
          uploadedAt: Date()
        )
        successfulBlobNotification(blobEntry: blobEntry)
        blobGlobalState.blobEntries.append(blobEntry)
      }
    }) {
      Image(systemName: "viewfinder")
      Text("Screenshot")
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
