import SwiftUI

struct StatisticsButton: View {
  var body: some View {
    Button(action: {
      print("Statistics button pressed.")
    }) {
      Image(systemName: "chart.pie")
      Text("Statistics")
    }
  }
}
