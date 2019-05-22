//
//  AnalyticsManager.swift
//  Swappy
//
//  Created by Mihail on 28/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol AnalyticsManager: class {
    
    func configure(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    
    func appBecomeActive()
    
    func track(screen: AnalyticScreen)
    
    func track(event: AnalyticEvent)
}

extension AnalyticsManager {
    func appBecomeActive() {}
}

final class AnalyticsManagerImp {
    
    private let managers: [AnalyticsManager] = [
        AppMetricaManager(),
        FirebaseAnalyticsManager(),
        FacebookAnalyticsManager()
    ]
}

extension AnalyticsManagerImp: AnalyticsManager {
    
    func configure(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        for manager in managers {
            manager.configure(application: application, launchOptions: launchOptions)
        }
    }
    
    func track(screen: AnalyticScreen) {
        for manager in managers {
            manager.track(screen: screen)
        }
    }
    
    func track(event: AnalyticEvent) {
        for manager in managers {
            manager.track(event: event)
        }
    }
    
    func appBecomeActive() {
        for manager in managers {
            manager.appBecomeActive()
        }
    }
}


