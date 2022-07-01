import SwiftUI
import Vision

struct ScreenshotButton: View {
  @Binding var previousUploadURL: String
  @Binding var previousUploadLocalPath: URL?
  @Binding var uploadProgress: Double
  @Binding var recognizedText: String?

  func recognizeTextHandler(request: VNRequest, error: Error?) {
    guard
      let observations =
        request.results as? [VNRecognizedTextObservation]
    else {
      return
    }
    let recognizedStrings = observations.compactMap { observation in
      return observation.topCandidates(1).first?.string
    }

    self.recognizedText = recognizedStrings.joined(separator: " ")
  }

  var body: some View {
    Button(action: {
      let filepath = captureScreenshot()
      let (destinationURL, uploadTask, localPath) = uploadBlob(filepath: filepath)

      uploadTask.observe(.progress) { snapshot in
        uploadProgress = snapshot.progress?.fractionCompleted ?? 0
      }
      uploadTask.observe(.success) { _ in
        NSSound(named: "Funk")?.play()
        replaceClipboard(with: destinationURL)
        previousUploadURL = destinationURL
        previousUploadLocalPath = localPath
        let nsImage = NSImage(contentsOf: previousUploadLocalPath!)
        let cgImage = nsImage!.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        do {
          try requestHandler.perform([request])
        } catch {
          print("Unable to perform the requests: \(error).")
        }
      }
    }) {
      Text("Screenshot (")
      Image(systemName: "command")
      Image(systemName: "shift")
      Text("Z )")
    }
  }
}

struct ScreenshotButton_Previews: PreviewProvider {
  static var previews: some View {
    ScreenshotButton(
      previousUploadURL: .constant("https://google.com"), previousUploadLocalPath: .constant(nil),
      uploadProgress: .constant(1.0), recognizedText: .constant("Placeholder"))
  }
}
