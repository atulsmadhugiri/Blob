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
  var uploadedAt: Date = Date.now

  init(
    id: UUID = UUID(),
    uploadProgress: Double = 1.0,
    uploadURL: String,
    uploadLocalPath: URL? = nil,
    fileSize: String? = nil,
    mimeType: String? = nil,
    uploadedAt: Date
  ) {
    self.id = id
    self.uploadProgress = uploadProgress
    self.uploadURL = uploadURL
    self.uploadLocalPath = uploadLocalPath
    self.fileSize = fileSize
    self.mimeType = mimeType
    self.uploadedAt = uploadedAt
  }
}

@Observable class BlobGlobalState {
  var blobEntries: [BlobEntry] = []
}
