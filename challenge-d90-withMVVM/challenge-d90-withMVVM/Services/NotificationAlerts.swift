//
//  NotificationAlerts.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 05.09.2022..
//

import UIKit
import UserNotifications

class NotificationAlerts {

    static let shared = NotificationAlerts()

    func registerApp() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in

            guard error == nil else {
                fatalError("Notification issue occurred")
            }

            if granted {
                print("Access granted")
            } else {
                print("Access denied")
            }
        }
    }

    func scheduleNotification(in viewController: UIViewController & UNUserNotificationCenterDelegate, for meme: Meme) {
        let center = UNUserNotificationCenter.current()
        center.delegate = viewController

        let show = UNNotificationAction(identifier: "open", title: "Open image", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

        center.setNotificationCategories([category])
        center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = "Your memes await"

        if meme.hasBottomText && meme.hasTopText {
            content.body = "Share your meme!"
        } else {
            content.body = "Finish your meme!"
        }

        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": meme.imageName]
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 * 60 * 24, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
