import SwiftUI

struct BlobListCell: View {
  var imagePath: URL?
  var filename: String
  var filesize: String
  var fileMIME: String

  var body: some View {
    HStack {
      AsyncImage(url: imagePath) { image in
        image.resizable().scaledToFit().cornerRadius(8).frame(width: 48, height: 48)
      } placeholder: {
        Color.gray.opacity(0.1).cornerRadius(8).frame(width: 48, height: 48)
      }
      VStack(alignment: .leading) {
        Text(filename).font(.headline)
        HStack {
          Text(fileMIME).font(.caption2.monospaced())
          Text(filesize).font(.caption2.monospaced()).foregroundColor(.gray)
        }
      }
    }
  }
}

struct BlobListCell_Previews: PreviewProvider {
  static var previews: some View {
    BlobListCell(
      imagePath: URL(string: "https://blob.sh/atul.png"), filename: "filename.extension",
      filesize: "[432kb]", fileMIME: "application/octet-stream")
  }
}
