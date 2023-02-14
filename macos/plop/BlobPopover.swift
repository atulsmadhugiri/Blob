import SwiftUI

struct BlobPopover: View {
  @ObservedObject var blobGlobalState: BlobGlobalState

  var body: some View {
    VStack {
      HStack {
        ScreenshotButton(
          blobGlobalState: blobGlobalState,
          uploadProgress: $blobGlobalState.blobEntries.last?.uploadProgress ?? .constant(0.0))
        RecordButton()
        UploadButton(
          previousUploadURL: $blobGlobalState.blobEntries.last?.uploadURL ?? .constant(""),
          uploadProgress: $blobGlobalState.blobEntries.last?.uploadProgress ?? .constant(0.0))
      }

      UploadProgressView(
        uploadProgress: $blobGlobalState.blobEntries.last?.uploadProgress ?? .constant(0.0))

      HStack {
        TextField("", text: $blobGlobalState.blobEntries.last?.uploadURL ?? .constant("")).frame(
          width: 208)
        CopyButton(previousUploadURL: $blobGlobalState.blobEntries.last?.uploadURL ?? .constant(""))
        OpenButton(previousUploadURL: $blobGlobalState.blobEntries.last?.uploadURL ?? .constant(""))
      }

      Divider()

      BlobPreview(
        previousUploadLocalPath: $blobGlobalState.blobEntries.last?.uploadLocalPath
          ?? .constant(URL(string: "")))

      Divider()

      List {
        ForEach($blobGlobalState.blobEntries.reversed(), id: \.id) { blobEntry in
          BlobListCell(blobEntry: blobEntry)
        }
      }.listStyle(.sidebar)

    }.padding(.all, 10).padding(.top, 10)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover(blobGlobalState: BlobGlobalState())
  }
}
