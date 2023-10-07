import SwiftUI

struct BlobListCell: View {
  var blobEntry: BlobEntry

  var body: some View {
    HStack {
      BlobPreview(previousUploadLocalPath: blobEntry.uploadLocalPath, width: 96, height: 64)
      VStack(alignment: .leading) {
        Text(blobEntry.uploadLocalPath?.lastPathComponent ?? "").font(.headline)
        HStack {
          Text(blobEntry.fileSize ?? "[filesize]").font(.caption2.monospaced())
          Text("[\(blobEntry.mimeType ?? "mime")]").font(.caption2.monospaced()).foregroundColor(
            .gray)
        }
        Text(getFormattedDateTime(fromDate: blobEntry.uploadedAt))
          .font(.caption.monospaced())
      }
      Spacer()
      VStack {
        CopyButton(previousUploadURL: .constant(blobEntry.uploadURL))
        OpenButton(previousUploadURL: .constant(blobEntry.uploadURL))
      }
    }
  }
}
