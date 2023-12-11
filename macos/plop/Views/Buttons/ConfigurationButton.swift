import SwiftUI

struct ConfigurationButton: View {
  var body: some View {
    Button(action: {
      print("Configuration button pressed.")
    }) {
      Image(systemName: "gear")
      Text("Configuration")
    }
  }
}
