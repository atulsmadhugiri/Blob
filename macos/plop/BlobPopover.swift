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
        previousUploadLocalPath: blobGlobalState.blobEntries.last?.uploadLocalPath
          ?? URL(string: ""))

      UploadProgressView(
        uploadProgress: $blobGlobalState.blobEntries.last?.uploadProgress ?? .constant(0.0))

      HStack {
        TextField("", text: $blobGlobalState.blobEntries.last?.uploadURL ?? .constant("")).frame(
          width: 208
        ).textFieldStyle(.roundedBorder)
        CopyButton(previousUploadURL: $blobGlobalState.blobEntries.last?.uploadURL ?? .constant(""))
        OpenButton(previousUploadURL: $blobGlobalState.blobEntries.last?.uploadURL ?? .constant(""))
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
