import SwiftUI

struct BlobPopover: View {
  @ObservedObject var blobGlobalState: BlobGlobalState

  var body: some View {
    VStack {
      HStack {
        ScreenshotButton(
          previousUploadURL: $blobGlobalState.blobEntries.last!.uploadURL,
          previousUploadLocalPath: $blobGlobalState.blobEntries.last!.uploadLocalPath,
          uploadProgress: $blobGlobalState.blobEntries.last!.uploadProgress)
        UploadButton(
          previousUploadURL: $blobGlobalState.blobEntries.last!.uploadURL,
          uploadProgress: $blobGlobalState.blobEntries.last!.uploadProgress)
      }

      UploadProgressView(uploadProgress: $blobGlobalState.blobEntries.last!.uploadProgress)

      HStack {
        TextField("", text: $blobGlobalState.blobEntries.last!.uploadURL).frame(width: 208)
        CopyButton(previousUploadURL: $blobGlobalState.blobEntries.last!.uploadURL)
        OpenButton(previousUploadURL: $blobGlobalState.blobEntries.last!.uploadURL)
      }

      Divider()

      BlobPreview(previousUploadLocalPath: $blobGlobalState.blobEntries.last!.uploadLocalPath)

      Divider()

      BlobList()
    }.padding(.all, 10).padding(.top, 10)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover(blobGlobalState: BlobGlobalState())
  }
}
