//
//  Notification.swift
//  Notifications
//
//  Created by Edgar on 23.03.21.
//

import UIKit
import UserNotifications

class Notification: NSObject {
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("User granted \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    private func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Settings \(settings)")
        }
    }
    
    func scheduleNotification(withType notificationName: String) {
        let content = UNMutableNotificationContent()
        let userAction = "User Action"
        
        content.title = notificationName
        content.body = "This is example how to create \(notificationName)"
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userAction
        
        if let imagePath = Bundle.main.path(forResource: "favicon", ofType: "png") {
            let url = URL(fileURLWithPath: imagePath)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "favicon",
                                                              url: url,
                                                              options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment couldn't be loaded")
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Local Notification"
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let er = error {
                print("Notification error \(er.localizedDescription)")
            }
        }
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: userAction,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [], options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
}

extension Notification: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Local Notification was received")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default Action")
        case "Snooze":
            print("Snooze Action")
            scheduleNotification(withType: "Reminder")
        case "Delete":
            print("Delete Action")
        default:
            print("Unknow Action")
        }
        
        completionHandler()
    }
}
