import FirebaseStorage
import Foundation

class BlobEntry: ObservableObject, Identifiable {
  @Published var uploadProgress: Double = 1.0
  @Published var uploadURL: String = ""
  @Published var uploadLocalPath: URL?
  @Published var uploadTask: StorageUploadTask?
  @Published var fileSize: String?
  @Published var mimeType: String?
}

class BlobGlobalState: ObservableObject {
  @Published var blobEntries: [BlobEntry] = []
}
