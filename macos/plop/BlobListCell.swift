import SwiftUI

struct BlobListCell: View {
  @Binding var blobEntry: BlobEntry
  var fileMIME: String?

  var body: some View {
    HStack {
      BlobPreview(previousUploadLocalPath: $blobEntry.uploadLocalPath, width: 96, height: 64)
      VStack(alignment: .leading) {
        Text(blobEntry.uploadLocalPath?.lastPathComponent ?? "").font(.headline)
        HStack {
          Text(fileMIME ?? "[mime]").font(.caption2.monospaced())
          Text(blobEntry.fileSize ?? "[filesize]").font(.caption2.monospaced()).foregroundColor(.gray)
        }
      }
      Spacer()
      CopyButton(previousUploadURL: .constant(blobEntry.uploadURL))
      OpenButton(previousUploadURL: .constant(blobEntry.uploadURL))
    }
  }
}
