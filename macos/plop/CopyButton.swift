import SwiftUI

struct CopyButton: View {
  var body: some View {
    if #available(macOS 11.0, *) {
      Image(systemName: "link.circle")
    } else {
      Text("Copy")
    }
  }
}

struct CopyButton_Previews: PreviewProvider {
  static var previews: some View {
    CopyButton()
  }
}
