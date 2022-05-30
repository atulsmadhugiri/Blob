import SwiftUI

struct UploadButton: View {
  var body: some View {
    if #available(macOS 11.0, *) {
      Text("Upload (")
      Image(systemName: "command")
      Image(systemName: "shift")
      Text("U )")
    } else {
      Text("Upload (CMD-SHIFT-U)")
    }
  }
}

struct UploadButton_Previews: PreviewProvider {
  static var previews: some View {
    UploadButton()
  }
}
