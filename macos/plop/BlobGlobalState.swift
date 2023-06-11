import FirebaseStorage
import Foundation
import Observation

@Observable class BlobEntry: Identifiable {
  var id = UUID()
  var uploadProgress: Double = 1.0
  var uploadURL: String = ""
  var uploadLocalPath: URL? = URL(fileURLWithPath: NSTemporaryDirectory())
  var fileSize: String? = "0kb"
  var mimeType: String? = "text/plain"
  var uploadedAt: Date = Date()

  init(
    id: UUID = UUID(),
    uploadURL: String,
    uploadLocalPath: URL? = nil
  ) {
    self.id = id
    self.uploadProgress = 1.0
    self.uploadURL = uploadURL
    self.uploadLocalPath = uploadLocalPath

    self.fileSize =
      (uploadLocalPath != nil)
      ? getFormattedFileSize(fromURL: uploadLocalPath!)
      : "0kb"

    self.mimeType =
      (uploadLocalPath != nil)
      ? getMIMEType(fromURL: uploadLocalPath!)
      : "text/plain"

    self.uploadedAt = Date()
  }
}

@Observable class BlobGlobalState {
  var blobEntries: [BlobEntry] = []
}
