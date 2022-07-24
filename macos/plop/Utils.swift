import AppKit
import FirebaseStorage
import Foundation

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
  let temporaryDirectory: String = NSTemporaryDirectory()
  let destinationPath = "\(temporaryDirectory)\(generateFileName())"

  let screenCaptureTask = Process()
  screenCaptureTask.launchPath = "/usr/sbin/screencapture"
  screenCaptureTask.arguments = ["-i", "-r", destinationPath]
  screenCaptureTask.qualityOfService = .userInteractive

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

  let uploadTask = destinationRef.putFile(from: URL(fileURLWithPath: filepath)) { _, error in
    if let error {
      print("Error uploading file to Google Cloud Storage: \(error)")
    }
  }

  return (destinationURL, uploadTask, URL(fileURLWithPath: filepath))
}
