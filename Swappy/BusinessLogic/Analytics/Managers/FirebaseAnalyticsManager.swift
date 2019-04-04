//
//  FirebaseAnalyticsManager.swift
//  Swappy
//
//  Created by Mihail on 04/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Firebase

final class FirebaseAnalyticsManager: AnalyticsManager {
    
    func configure(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        FirebaseApp.configure()
    }
    
    func track(event: AnalyticEvent) {
        Analytics.logEvent(event.rawValue, parameters: nil)
    }
    
    func track(screen: AnalyticScreen) {
        Analytics.logEvent(screen.rawValue, parameters: nil)
    }
}
