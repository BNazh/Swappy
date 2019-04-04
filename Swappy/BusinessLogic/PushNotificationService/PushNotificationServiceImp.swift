//
//  PushNotificationServiceImp.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 03/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Firebase

final class PushNotificationServiceImp: NSObject {
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        let options = FirebaseOptions(googleAppID: "", gcmSenderID: "")
        options.bundleID = ""
        options.apiKey = ""
        options.projectID = ""
        options.clientID = ""
        FirebaseApp.configure(options: options)
        
        Messaging.messaging().delegate = self
    }
    
    // MARK: - Functions
    
    func setDeviceToken(_ deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

// MARK: - MessagingDelegate

extension PushNotificationServiceImp: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("FCM TOKEN: \(fcmToken)")
        // TODO: send fcm token
    }
}
