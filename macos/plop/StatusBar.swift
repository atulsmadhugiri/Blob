import AppKit

// Credit: AnaghSharma (MIT Licence)
// https://github.com/AnaghSharma/Ambar-SwiftUI/blob/master/Ambar/Helpers/StatusBarController.swift
class StatusBar {
  private var statusBar: NSStatusBar
  private var statusItem: NSStatusItem
  private var popover: NSPopover

  init(_ popover: NSPopover) {
    self.popover = popover
    statusBar = NSStatusBar()
    statusItem = statusBar.statusItem(withLength: 28.0)

    if let statusBarButton = statusItem.button {
      statusBarButton.image = #imageLiteral(resourceName: "atul_white")
      statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
      statusBarButton.image?.isTemplate = true
      statusBarButton.action = #selector(togglePopover(sender:))
      statusBarButton.target = self
    }
  }

  @objc func togglePopover(sender: AnyObject) {
    if popover.isShown {
      hidePopover(sender)
    } else {
      showPopover(sender)
    }
  }

  func showPopover(_: AnyObject) {
    if let statusBarButton = statusItem.button {
      popover.show(
        relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
    }
  }

  func hidePopover(_ sender: AnyObject) {
    popover.performClose(sender)
  }

  func mouseEventHandler(_ event: NSEvent?) {
    if popover.isShown {
      hidePopover(event!)
    }
  }
}
