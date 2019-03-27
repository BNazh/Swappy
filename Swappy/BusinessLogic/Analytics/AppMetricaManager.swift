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
    
    private let apiKey = "API_key"
}

extension AppMetricaManager: AnalyticsManagerProtocol {
    
    func track(screen: AnalyticScreen) {
        // TODO
    }
    
    func track(event: AnalyticEvent) {
        YMMYandexMetrica.reportEvent(event.rawValue, onFailure: nil)
    }
}
