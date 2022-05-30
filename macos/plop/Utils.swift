import Foundation
import AppKit

func replaceClipboard(with newString: String) {
  let pasteboard = NSPasteboard.general;
  pasteboard.clearContents()
  pasteboard.writeObjects([newString as NSString])
}
