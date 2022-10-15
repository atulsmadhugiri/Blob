import SwiftUI

struct BlobList: View {
  var body: some View {
    List {
      BlobListCell(
        imagePath: URL(string: "https://blob.sh/atul.png"), filename: "filename.extension",
        filesize: "[32kb]", fileMIME: "image/png")
      BlobListCell(
        imagePath: URL(string: "https://blob.sh/atul.png"), filename: "filename.extension",
        filesize: "[2gb]", fileMIME: "image/png")
      BlobListCell(
        imagePath: URL(string: "https://blob.sh/atul.png"), filename: "filename.extension",
        filesize: "[80pb]", fileMIME: "image/png")
      BlobListCell(
        imagePath: URL(string: "https://blob.sh/atul.png"), filename: "filename.extension",
        filesize: "[4mb]", fileMIME: "image/png")
    }.listStyle(.sidebar)
  }
}

struct BlobList_Previews: PreviewProvider {
  static var previews: some View {
    BlobList()
  }
}
