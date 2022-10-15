import SwiftUI

struct UploadProgressView: View {
  @Binding var uploadProgress: Double

  var body: some View {
    ProgressView("", value: uploadProgress, total: 1.0).padding(.horizontal, 20)
  }
}

struct UploadProgressView_Previews: PreviewProvider {
  static var previews: some View {
    UploadProgressView(uploadProgress: .constant(0.5))
  }
}
