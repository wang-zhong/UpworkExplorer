//
//  NotificationManager.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/10.
//

import AppKit

struct NotificationManager {
    static func triggerNotification(newJobCount: Int) {
        let notification = NSUserNotification()
        notification.identifier = UUID().uuidString
        notification.title = "Hurry Up!"
        notification.informativeText = "\(newJobCount) new jobs are posted."
        notification.soundName = NSUserNotificationDefaultSoundName
        
        let notificationCenter = NSUserNotificationCenter.default
        notificationCenter.deliver(notification)
    }
}
