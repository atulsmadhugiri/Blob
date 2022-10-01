import FirebaseStorage
import Foundation

class BlobEntry: ObservableObject {
  @Published var uploadProgress: Double = 1.0
  @Published var uploadURL: String = ""
  @Published var uploadLocalPath: URL?
  @Published var uploadTask: StorageUploadTask?
}

class BlobGlobalState: ObservableObject {
  @Published var blobEntries: [BlobEntry] = [BlobEntry()]
}
