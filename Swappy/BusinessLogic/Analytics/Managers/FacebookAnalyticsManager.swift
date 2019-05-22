//
//  FacebookAnalyticsManager.swift
//  Swappy
//
//  Created by Mihail on 21/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import FacebookCore
import FBSDKCoreKit

final class FacebookAnalyticsManager: AnalyticsManager {
    
    func appBecomeActive() {
        AppEvents.activateApp()
    }
    
    func configure(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        Settings.isAutoLogAppEventsEnabled = true
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func track(event: AnalyticEvent) {
        let facebookEvent = AppEvents.Name(rawValue: event.rawValue)
        AppEvents.logEvent(facebookEvent)
    }
    
    func track(screen: AnalyticScreen) {
        let facebookEvent = AppEvents.Name(rawValue: screen.rawValue)
        AppEvents.logEvent(facebookEvent)
    }
}

