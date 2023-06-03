import SwiftUI

struct DebugButton: View {
  var body: some View {
    Button(action: {
      print("Debug button pressed.")
    }) {
      Image(systemName: "ladybug")
      Text("Debug")
    }
  }
}
