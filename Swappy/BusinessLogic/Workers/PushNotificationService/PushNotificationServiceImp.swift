//
//  PushNotificationServiceImp.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 03/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Firebase
import UserNotifications

final class PushNotificationServiceImp: NSObject {
    
    // MARK: - Functions
    
    func setDeviceToken(_ deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension PushNotificationServiceImp: PushNotificationService {
    func register(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        FirebaseApp.configure()
    }
}

// MARK: - MessagingDelegate

extension PushNotificationServiceImp: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("FCM TOKEN: \(fcmToken)")
        // TODO: send fcm token
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension PushNotificationServiceImp: UNUserNotificationCenterDelegate {
    
    
}
