import SwiftUI

struct UploadProgressView: View {
  var uploadProgress: Double
  
  var body: some View {
    if #available(macOS 11.0, *) {
      ProgressView("", value: uploadProgress, total: 1.0).padding(.horizontal, 20)
    }
  }
}

struct UploadProgressView_Previews: PreviewProvider {
  static var previews: some View {
    UploadProgressView(uploadProgress: 0.5)
  }
}
