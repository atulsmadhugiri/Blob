import SwiftUI

struct ScreenshotButton: View {
  var body: some View {
    if #available(macOS 11.0, *) {
      Text("Screenshot (")
      Image(systemName: "command")
      Image(systemName: "shift")
      Text("Z )")
    } else {
      Text("Screenshot (CMD-SHIFT-Z)")
    }
  }
}

struct ScreenshotButton_Previews: PreviewProvider {
  static var previews: some View {
    ScreenshotButton()
  }
}
