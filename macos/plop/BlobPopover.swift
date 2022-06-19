import SwiftUI

struct BlobPopover: View {
  var body: some View {
    VStack {
      HStack {
        Button(action: {}) { ScreenshotButton() }
        Button(action: {}) { UploadButton() }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover()
  }
}
