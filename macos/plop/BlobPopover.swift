import SwiftUI

struct BlobPopover: View {
  @ObservedObject var blobGlobalState: BlobEntry

  var body: some View {
    VStack {
      HStack {
        ScreenshotButton(
          previousUploadURL: $blobGlobalState.uploadURL,
          previousUploadLocalPath: $blobGlobalState.uploadLocalPath,
          uploadProgress: $blobGlobalState.uploadProgress)
        UploadButton(
          previousUploadURL: $blobGlobalState.uploadURL,
          uploadProgress: $blobGlobalState.uploadProgress)
      }

      UploadProgressView(uploadProgress: blobGlobalState.uploadProgress)

      HStack {
        TextField("", text: $blobGlobalState.uploadURL).frame(width: 208)
        CopyButton(previousUploadURL: blobGlobalState.uploadURL)
        OpenButton(previousUploadURL: blobGlobalState.uploadURL)
      }

      Divider()

      BlobPreview(previousUploadLocalPath: blobGlobalState.uploadLocalPath)

    }.padding(.all, 10).padding(.top, 10)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover(blobGlobalState: BlobGlobalState().blobEntries.last!)
  }
}
