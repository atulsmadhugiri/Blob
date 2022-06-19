import SwiftUI

struct OpenButton: View {
  var previousUploadURL: String

  var body: some View {
    Button(action: {
      if let url: URL = URL(string: previousUploadURL) {
        NSWorkspace.shared.open(url)
      }
    }) {
      Image(systemName: "safari")
    }
  }
}

struct OpenButton_Previews: PreviewProvider {
  static var previews: some View {
    OpenButton(previousUploadURL: "https://google.com")
  }
}
