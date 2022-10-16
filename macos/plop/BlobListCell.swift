import SwiftUI

struct BlobListCell: View {
  @Binding var blobEntry: BlobEntry
  var filesize: String?
  var fileMIME: String?

  var body: some View {
    HStack {
      AsyncImage(url: blobEntry.uploadLocalPath) { image in
        image.resizable().scaledToFit().cornerRadius(8).frame(width: 48, height: 48)
      } placeholder: {
        Color.gray.opacity(0.1).cornerRadius(8).frame(width: 48, height: 48)
      }
      VStack(alignment: .leading) {
        Text(blobEntry.uploadLocalPath?.lastPathComponent ?? "").font(.headline)
        HStack {
          Text(fileMIME ?? "[mime]").font(.caption2.monospaced())
          Text(filesize ?? "[filesize]").font(.caption2.monospaced()).foregroundColor(.gray)
        }
      }
      Spacer()
      CopyButton(previousUploadURL: .constant(blobEntry.uploadURL))
      OpenButton(previousUploadURL: .constant(blobEntry.uploadURL))
    }
  }
}
