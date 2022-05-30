import Foundation
import AppKit

func replaceClipboard(with newString: String) -> Void {
  let pasteboard = NSPasteboard.general;
  pasteboard.clearContents()
  pasteboard.writeObjects([newString as NSString])
}

func generateFileName(nameLength: Int = 6, fileExtension: String = ".png") -> String {
  let randomString = UUID().uuidString.suffix(6).lowercased()
  return "\(randomString)\(fileExtension)"
}

func captureScreenshot() -> String {
  let temporaryDirectory: String = NSTemporaryDirectory()
  let destinationPath: String = "\(temporaryDirectory)\(generateFileName())"

  let screenCaptureTask: Process = Process()
  screenCaptureTask.launchPath = "/usr/sbin/screencapture"
  screenCaptureTask.arguments = ["-i", "-r", destinationPath]
  screenCaptureTask.qualityOfService = .userInteractive

  screenCaptureTask.launch()
  screenCaptureTask.waitUntilExit()

  return destinationPath
}
