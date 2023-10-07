import SwiftData
import SwiftUI

struct BlobPopover: View {
  @Bindable var blobGlobalState: BlobGlobalState
  @Query var entries: [BlobEntry]

  var body: some View {
    VStack {
      HStack {
        ScreenshotButton(uploadProgress: $blobGlobalState.uploadProgress)
        RecordButton()
        UploadButton(uploadProgress: $blobGlobalState.uploadProgress)
      }

      Divider()

      BlobPreview(previousUploadLocalPath: entries.last?.uploadLocalPath)

      UploadProgressView(uploadProgress: blobGlobalState.uploadProgress)

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
