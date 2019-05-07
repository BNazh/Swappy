//
//  AppsflyerAnalyticsManager.swift
//  Swappy
//
//  Created by Mihail on 08/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import AppsFlyerLib

final class AppsFlyerManager {
    
    let tracker = AppsFlyerTracker.shared()
    
    func setup() {
        tracker?.appsFlyerDevKey = "cZu6yLzsWM6gPkkAN3b5fH"
        tracker?.appleAppID = "1458535423"
    }
    
    func trackAppLaunch() {
        tracker?.trackAppLaunch()
    }
}
