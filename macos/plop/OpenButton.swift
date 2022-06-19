import SwiftUI

struct OpenButton: View {
  var body: some View {
    if #available(macOS 11.0, *) {
      Image(systemName: "safari")
    } else {
      Text("Open")
    }
  }
}

struct OpenButton_Previews: PreviewProvider {
  static var previews: some View {
    OpenButton()
  }
}
