import SwiftData
import SwiftUI

struct ScreenshotButton: View {
  @Binding var uploadProgress: Double
  @Environment(\.modelContext) private var modelContext

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
        let blobEntry = BlobEntry(uploadURL: destinationURL, uploadLocalPath: localPath)
        successfulBlobNotification(blobEntry: blobEntry)
        modelContext.insert(blobEntry)
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
      uploadProgress: .constant(1.0))
  }
}
