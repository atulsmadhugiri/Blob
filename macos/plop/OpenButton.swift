import SwiftUI

struct OpenButton: View {
  @Binding var previousUploadURL: String

  var body: some View {
    Button(action: {
      if let url: URL = URL(string: previousUploadURL) {
        NSWorkspace.shared.open(url)
      }
    }) {
      Image(systemName: "arrow.up.right.square")
    }
  }
}

struct OpenButton_Previews: PreviewProvider {
  static var previews: some View {
    OpenButton(previousUploadURL: .constant("https://google.com"))
  }
}
