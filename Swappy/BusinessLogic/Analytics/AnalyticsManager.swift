//
//  AnalyticsManager.swift
//  Swappy
//
//  Created by Mihail on 28/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol AnalyticsManager: class {
    
    func configure(launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    
    func track(screen: AnalyticScreen)
    
    func track(event: AnalyticEvent)
}

final class AnalyticsManagerImp {
    
    private let managers = [AppMetricaManager()]
}

extension AnalyticsManagerImp: AnalyticsManager {
    
    func configure(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        for manager in managers {
            manager.configure(launchOptions: launchOptions)
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
}


