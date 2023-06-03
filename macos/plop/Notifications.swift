import Foundation
import UserNotifications

func successfulBlobNotification(blobEntry: BlobEntry) {
  let notifCenter = UNUserNotificationCenter.current()
  notifCenter.getNotificationSettings { (settings) in
    switch settings.authorizationStatus {
    case .authorized, .provisional:
      let notifContent = UNMutableNotificationContent()

      notifContent.title = blobEntry.uploadLocalPath?.lastPathComponent ?? "FILE NAME"
      notifContent.subtitle = blobEntry.mimeType ?? "FILE TYPE"
      notifContent.body = blobEntry.fileSize ?? "FILE SIZE"

      do {
        let filename = blobEntry.uploadLocalPath!.lastPathComponent
        let temporaryPath: String = "\(NSTemporaryDirectory())notifAttach/\(filename)"
        let temporaryPathURL: URL = URL(fileURLWithPath: temporaryPath)

        try FileManager().createDirectory(
          at: temporaryPathURL.deletingLastPathComponent(),
          withIntermediateDirectories: true
        )

        try FileManager().copyItem(
          at: blobEntry.uploadLocalPath!,
          to: temporaryPathURL
        )

        let notifAttachment = try UNNotificationAttachment(
          identifier: "image",
          url: temporaryPathURL
        )
        notifContent.attachments = [notifAttachment]
      } catch {
        print("Unable to add attachment to notification.")
      }

      let notifRequest = UNNotificationRequest(
        identifier: UUID().uuidString,
        content: notifContent,
        trigger: nil
      )
      notifCenter.add(notifRequest)

    case .denied, .notDetermined:
      print("Notification permission denied.")

    @unknown default:
      print("Unknown case introduced in new version of macOS.")
    }
  }
}
