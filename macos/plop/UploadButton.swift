import SwiftUI

struct UploadButton: View {
  var body: some View {
    Text("Upload (")
    Image(systemName: "command")
    Image(systemName: "shift")
    Text("U )")
  }
}

struct UploadButton_Previews: PreviewProvider {
  static var previews: some View {
    UploadButton()
  }
}
