import SwiftUI

struct BlobPopover: View {
  @ObservedObject var blobGlobalState: BlobGlobalState

  var body: some View {
    VStack {
      HStack {
        ScreenshotButton(
          previousUploadURL: $blobGlobalState.previousUploadURL,
          previousUploadLocalPath: $blobGlobalState.previousUploadLocalPath,
          uploadProgress: $blobGlobalState.uploadProgress)
        UploadButton(
          previousUploadURL: $blobGlobalState.previousUploadURL,
          uploadProgress: $blobGlobalState.uploadProgress)
      }

      UploadProgressView(uploadProgress: blobGlobalState.uploadProgress)

      HStack {
        TextField("", text: $blobGlobalState.previousUploadURL).frame(width: 208)
        CopyButton(previousUploadURL: blobGlobalState.previousUploadURL)
        OpenButton(previousUploadURL: blobGlobalState.previousUploadURL)
      }

      Divider()

      BlobPreview(previousUploadLocalPath: blobGlobalState.previousUploadLocalPath)

    }.padding(.all, 10).padding(.top, 10)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover(blobGlobalState: BlobGlobalState())
  }
}
