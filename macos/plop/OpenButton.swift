import SwiftUI

struct OpenButton: View {
  var previousUploadURL: String

  var body: some View {
    Button(action: {
      if let url: URL = URL(string: previousUploadURL) {
        NSWorkspace.shared.open(url)
      }
    }) {
      if #available(macOS 11.0, *) {
        Image(systemName: "safari")
      } else {
        Text("Open")
      }
    }
  }
}

struct OpenButton_Previews: PreviewProvider {
  static var previews: some View {
    OpenButton(previousUploadURL: "https://google.com")
  }
}
