import Foundation

class BlobGlobalState: ObservableObject {
  @Published var uploadProgress: Double = 1.0
  @Published var previousUploadURL: String = ""
  @Published var previousUploadLocalPath: URL?
  @Published var anonymousUploadsEnabled: Bool = false
}
