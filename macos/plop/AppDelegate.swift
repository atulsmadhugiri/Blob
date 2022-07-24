import FirebaseCore
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var statusBar: StatusBar?
  var popover = NSPopover()
  var blobGlobalState = BlobGlobalState()

  func applicationDidFinishLaunching(_: Notification) {
    FirebaseApp.configure()

    // We use NSPopover in place of NSWindow so icon appears in menubar.
    // Credit: Anagh Sharma (https://github.com/AnaghSharma)
    let contentView = BlobPopover(blobGlobalState: blobGlobalState)
    popover.contentSize = NSSize(width: 360, height: 360)
    popover.contentViewController = NSHostingController(rootView: contentView)
    popover.animates = false
    popover.behavior = NSPopover.Behavior.transient

    statusBar = StatusBar(popover)
  }
}
