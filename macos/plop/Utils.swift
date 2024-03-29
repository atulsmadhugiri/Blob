import AppKit
import FirebaseStorage
import Foundation
import UniformTypeIdentifiers

func replaceClipboard(with newString: String) {
  let pasteboard = NSPasteboard.general
  pasteboard.clearContents()
  pasteboard.writeObjects([newString as NSString])
}

func generateFileName(nameLength: Int = 6, fileExtension: String = ".png") -> String {
  let randomString = UUID().uuidString.suffix(nameLength).lowercased()
  return "\(randomString)\(fileExtension)"
}

func captureScreenshot() -> String {
  let temporaryDirectory = URL.homeDirectory.appending(path: ".blob", directoryHint: .isDirectory)

  do {
    try FileManager().createDirectory(
      at: temporaryDirectory,
      withIntermediateDirectories: true
    )
  } catch {
    print("Unable to create $HOME/.blob/ directory.")
  }

  let destinationPath = "\(temporaryDirectory.path())\(generateFileName())"

  let screenCaptureTask = Process()
  screenCaptureTask.launchPath = "/usr/sbin/screencapture"
  screenCaptureTask.arguments = ["-i", "-r", destinationPath]

  screenCaptureTask.launch()
  screenCaptureTask.waitUntilExit()

  return destinationPath
}

func uploadBlob(filepath: String) -> (
  destinationURL: String, uploadTask: StorageUploadTask, localPath: URL
) {
  let filename: String = URL(fileURLWithPath: filepath).lastPathComponent

  let storageBucket = Storage.storage(url: "gs://\(GCLOUD_STORAGE_BUCKET)").reference()
  let destinationRef = storageBucket.child("\(filename)")
  let destinationURL = "https://\(GCLOUD_STORAGE_BUCKET)\(filename)"

  let uploadTask: StorageUploadTask = destinationRef.putFile(from: URL(fileURLWithPath: filepath)) {
    _, error in
    if let error {
      print("Error uploading file to Google Cloud Storage: \(error)")
    }
  }

  return (destinationURL, uploadTask, URL(fileURLWithPath: filepath))
}

func getFormattedFileSize(fromURL url: URL) -> String? {
  do {
    let resourceValues = try url.resourceValues(forKeys: [.fileSizeKey])
    let fileSize = resourceValues.fileSize!
    return ByteCountFormatter().string(fromByteCount: Int64(fileSize))
  } catch {
    print("Error getting formatted fileSize from URL.")
  }
  return nil
}

func getMIMEType(fromURL url: URL) -> String? {
  if let pathSuffix = UTType(filenameExtension: url.pathExtension) {
    return pathSuffix.preferredMIMEType
  }
  return nil
}

func getFormattedDateTime(fromDate date: Date) -> String {
  let fmt = DateFormatter()
  fmt.dateStyle = .medium
  fmt.timeStyle = .short
  return fmt.string(from: date)
}
