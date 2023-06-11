import FirebaseStorage
import Foundation
import Observation

class BlobEntry: ObservableObject, Identifiable {
  @Published var id = UUID()
  @Published var uploadProgress: Double = 1.0
  @Published var uploadURL: String = ""
  @Published var uploadLocalPath: URL?
  @Published var uploadTask: StorageUploadTask?
  @Published var fileSize: String?
  @Published var mimeType: String?
  @Published var uploadedAt: Date?
}

@Observable class BlobGlobalState {
  var blobEntries: [BlobEntry] = []
}
