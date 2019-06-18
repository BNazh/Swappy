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
    
    func configure(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        let apiKey = AppConstants.Keys.appmetrica
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
