//
//  AppMetricaManager.swift
//  Swappy
//
//  Created by Mihail on 28/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import YandexMobileMetrica
import UIKit

final class AppMetricaManager {
    
    
}

extension AppMetricaManager: AnalyticsManager {
    
    func configure(launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        let apiKey = "e5fa98a5-b630-47e9-ab2f-69ce2c46ef1e"
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: apiKey) else {
            return
        }
        YMMYandexMetrica.activate(with: configuration)
    }
    
    func track(screen: AnalyticScreen) {
        YMMYandexMetrica.reportEvent(screen.rawValue, onFailure: nil)
    }
    
    func track(event: AnalyticEvent) {
        YMMYandexMetrica.reportEvent(event.rawValue, onFailure: nil)
    }
}
