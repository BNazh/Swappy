//
//  AnalyticsManager.swift
//  Swappy
//
//  Created by Mihail on 28/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol AnalyticsManagerProtocol: class {
    
    func track(screen: AnalyticScreen)
    
    func track(event: AnalyticEvent)
}

final class AnalyticsManager {
    
    static let shared: AnalyticsManagerProtocol = AnalyticsManager()
    
    let managers = [AppMetricaManager()]
    
    private init() {}
}

extension AnalyticsManager: AnalyticsManagerProtocol {
    
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


