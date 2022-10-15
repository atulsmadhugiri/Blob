import SwiftUI

struct CopyButton: View {
  @Binding var previousUploadURL: String

  var body: some View {
    Button(action: {
      replaceClipboard(with: previousUploadURL)
    }) {
      Image(systemName: "square.on.square")
    }
  }
}

struct CopyButton_Previews: PreviewProvider {
  static var previews: some View {
    CopyButton(previousUploadURL: .constant("https://google.com"))
  }
}
