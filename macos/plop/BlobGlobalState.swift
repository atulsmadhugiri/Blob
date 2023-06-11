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
}

@Observable class BlobGlobalState {
  var blobEntries: [BlobEntry] = []
}
