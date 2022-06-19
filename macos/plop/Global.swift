import Foundation

class Global: ObservableObject {
  @Published var previousUploadURL = ""
  @Published var anonymousUploadsEnabled = false;
}
