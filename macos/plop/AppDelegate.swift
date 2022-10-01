import FirebaseCore
import HotKey
import SQLite
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var statusBar: StatusBar?
  var popover = NSPopover()
  var blobGlobalState = BlobGlobalState()

  var screenshotHotKey = HotKey(key: .z, modifiers: [.command, .shift])
  var uploadHotKey = HotKey(key: .u, modifiers: [.command, .shift])

  func applicationDidFinishLaunching(_: Notification) {
    initializeSQLiteDB()
    FirebaseApp.configure()
    configureScreenshotHotKey()
    configureUploadHotKey()

    // We use NSPopover in place of NSWindow so icon appears in menubar.
    // Credit: Anagh Sharma (https://github.com/AnaghSharma)
    let contentView = BlobPopover(blobGlobalState: blobGlobalState.blobEntries.last!)
    popover.contentSize = NSSize(width: 360, height: 360)
    popover.contentViewController = NSHostingController(rootView: contentView)
    popover.animates = false
    popover.behavior = NSPopover.Behavior.transient

    statusBar = StatusBar(popover)
  }

  func initializeSQLiteDB() {
    let fileManager = FileManager.default
    if let appSupportDirectoryURL = fileManager.urls(
      for: .applicationSupportDirectory, in: .userDomainMask
    ).first {
      let blobSupportDirectoryURL = appSupportDirectoryURL.appendingPathComponent(
        Bundle.main.bundleIdentifier!)
      do {
        try fileManager.createDirectory(
          at: blobSupportDirectoryURL, withIntermediateDirectories: true)
        let _ = try Connection(
          blobSupportDirectoryURL.appendingPathComponent("clientDB.sqlite3").absoluteString)
      } catch {
        print(error)
      }
    }
  }

  func configureScreenshotHotKey() {
    screenshotHotKey.keyDownHandler = {
      NSApp.activate(ignoringOtherApps: true)
      let filepath = captureScreenshot()
      let (destinationURL, uploadTask, localPath) = uploadBlob(filepath: filepath)

      uploadTask.observe(.progress) { snapshot in
        self.blobGlobalState.blobEntries.last?.uploadProgress =
          snapshot.progress?.fractionCompleted ?? 0
      }

      uploadTask.observe(.success) { _ in
        NSSound(named: "Funk")?.play()
        replaceClipboard(with: destinationURL)
        self.blobGlobalState.blobEntries.last?.uploadURL = destinationURL
        self.blobGlobalState.blobEntries.last?.uploadLocalPath = localPath
      }
    }
  }

  func configureUploadHotKey() {
    uploadHotKey.keyDownHandler = {
      NSApp.activate(ignoringOtherApps: true)
      let fileSelectionDialog = NSOpenPanel()
      if fileSelectionDialog.runModal() == NSApplication.ModalResponse.OK {
        if let filepath = fileSelectionDialog.url {
          let (destinationURL, uploadTask, localPath) = uploadBlob(
            filepath: filepath.path)

          uploadTask.observe(.progress) { snapshot in
            self.blobGlobalState.blobEntries.last?.uploadProgress =
              snapshot.progress?.fractionCompleted ?? 0
          }

          uploadTask.observe(.success) { _ in
            NSSound(named: "Funk")?.play()
            replaceClipboard(with: destinationURL)
            self.blobGlobalState.blobEntries.last?.uploadURL = destinationURL
            self.blobGlobalState.blobEntries.last?.uploadLocalPath = localPath
          }
        }
      }
    }
  }
}
