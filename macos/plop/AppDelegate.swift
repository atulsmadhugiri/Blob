import FirebaseCore
import HotKey
import SwiftData
import SwiftUI
import UserNotifications

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var statusBar: StatusBar?
  var popover = NSPopover()
  var blobGlobalState = BlobGlobalState()

  var screenshotHotKey = HotKey(key: .z, modifiers: [.command, .shift])
  var uploadHotKey = HotKey(key: .u, modifiers: [.command, .shift])

  var blobEntryContainer: ModelContainer?

  func applicationDidFinishLaunching(_: Notification) {
    FirebaseApp.configure()
    configureScreenshotHotKey()
    configureUploadHotKey()

    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.requestAuthorization(options: [.alert, .badge]) { (granted, error: Error?) in
      if let error = error {
        print("Error: \(error.localizedDescription)")
      }

      print(
        granted
          ? "Notification permission granted."
          : "Notification permission denied."
      )
    }

    do {
      // We use NSPopover in place of NSWindow so icon appears in menubar.
      // Credit: Anagh Sharma (https://github.com/AnaghSharma)
      blobEntryContainer = try ModelContainer(for: BlobEntry.self)
      let contentView = BlobPopover(blobGlobalState: blobGlobalState).modelContainer(
        blobEntryContainer!)
      popover.contentSize = NSSize(width: 400, height: 800)
      popover.contentViewController = NSHostingController(rootView: contentView)
      popover.animates = false
      popover.behavior = NSPopover.Behavior.transient

      statusBar = StatusBar(popover)
    } catch {
      print("Failed to instantiate ModelContainer for BlobEntry")
    }
  }

  @MainActor
  func configureScreenshotHotKey() {
    screenshotHotKey.keyDownHandler = {
      NSApp.activate(ignoringOtherApps: true)
      let filepath = captureScreenshot()
      let (destinationURL, uploadTask, localPath) = uploadBlob(filepath: filepath)

      uploadTask.observe(.progress) { snapshot in
        self.blobGlobalState.uploadProgress =
          snapshot.progress?.fractionCompleted ?? 0
      }

      uploadTask.observe(.success) { _ in
        NSSound(named: "Funk")?.play()
        replaceClipboard(with: destinationURL)
        let blobEntry = BlobEntry(uploadURL: destinationURL, uploadLocalPath: localPath)
        successfulBlobNotification(blobEntry: blobEntry)
        self.blobEntryContainer?.mainContext.insert(blobEntry)
      }
    }
  }

  @MainActor
  func configureUploadHotKey() {
    uploadHotKey.keyDownHandler = {
      NSApp.activate(ignoringOtherApps: true)
      let fileSelectionDialog = NSOpenPanel()
      if fileSelectionDialog.runModal() == NSApplication.ModalResponse.OK {
        if let filepath = fileSelectionDialog.url {
          let (destinationURL, uploadTask, localPath) = uploadBlob(
            filepath: filepath.path)

          uploadTask.observe(.progress) { snapshot in
            self.blobGlobalState.uploadProgress =
              snapshot.progress?.fractionCompleted ?? 0
          }

          uploadTask.observe(.success) { _ in
            NSSound(named: "Funk")?.play()
            replaceClipboard(with: destinationURL)
            let blobEntry = BlobEntry(uploadURL: destinationURL, uploadLocalPath: localPath)
            successfulBlobNotification(blobEntry: blobEntry)
            self.blobEntryContainer?.mainContext.insert(blobEntry)
          }
        }
      }
    }
  }
}
