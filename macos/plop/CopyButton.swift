import SwiftUI

struct CopyButton: View {
  var previousUploadURL: String
  
  var body: some View {
    Button(action: {
      replaceClipboard(with: previousUploadURL)
    }) {
      if #available(macOS 11.0, *) {
        Image(systemName: "link.circle")
      } else {
        Text("Copy")
      }
    }
  }
}

struct CopyButton_Previews: PreviewProvider {
  static var previews: some View {
    CopyButton(previousUploadURL: "https://google.com")
  }
}
