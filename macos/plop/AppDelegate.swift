import SwiftUI
import FirebaseCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var statusBar: StatusBar?
  var popover = NSPopover.init()
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    FirebaseApp.configure()
    
    // We use NSPopover in place of NSWindow so icon appears in menubar.
    // Credit: Anagh Sharma (https://github.com/AnaghSharma)
    let contentView = BlobPopover()
    popover.contentSize = NSSize(width: 360, height: 360)
    popover.contentViewController = NSHostingController(rootView: contentView)
    popover.animates = false
    popover.behavior = NSPopover.Behavior.transient
    
    statusBar = StatusBar.init(popover)
  }
  
}
