import SwiftUI

struct RecordButton: View {
  var body: some View {
    Button(action: {}) {
      Image(systemName: "dot.circle.viewfinder")
      Text("Record")
    }
  }
}

struct RecordButton_Previews: PreviewProvider {
  static var previews: some View {
    RecordButton()
  }
}
