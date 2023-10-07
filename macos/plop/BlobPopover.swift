import SwiftData
import SwiftUI

struct BlobPopover: View {
  @Bindable var blobGlobalState: BlobGlobalState
  @Query var entries: [BlobEntry]

  var body: some View {
    VStack {
      HStack {
        ScreenshotButton(
          uploadProgress: $blobGlobalState.blobEntries.last?.uploadProgress ?? .constant(0.0))
        RecordButton()
        UploadButton(
          previousUploadURL: $blobGlobalState.blobEntries.last?.uploadURL ?? .constant(""),
          uploadProgress: $blobGlobalState.blobEntries.last?.uploadProgress ?? .constant(0.0))
      }

      Divider()

      BlobPreview(
        previousUploadLocalPath: entries.last?.uploadLocalPath ?? URL(string: ""))

      UploadProgressView(
        uploadProgress: $blobGlobalState.blobEntries.last?.uploadProgress ?? .constant(0.0))

      HStack {
        TextField("", text: .constant(entries.last?.uploadURL ?? "")).frame(
          width: 208
        ).textFieldStyle(.roundedBorder)
        CopyButton(previousUploadURL: entries.last?.uploadURL ?? "")
        OpenButton(previousUploadURL: entries.last?.uploadURL ?? "")
      }

      Divider()

      List {
        ForEach(entries.reversed(), id: \.id) { blobEntry in
          BlobListCell(blobEntry: blobEntry)
        }
      }.listStyle(.sidebar)

      Divider()

      HStack {
        StatisticsButton()
        ConfigurationButton()
        DebugButton()
      }

    }.padding(.all, 10).padding(.top, 10)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover(blobGlobalState: BlobGlobalState())
  }
}
