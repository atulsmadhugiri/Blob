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
        let notifAttachment = try UNNotificationAttachment(
          identifier: "image",
          url: blobEntry.uploadLocalPath!
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
