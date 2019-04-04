//
//  UIViewController+Swizzling.swift
//  Swappy
//
//  Created by Mihail on 05/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import SwinjectStoryboard

protocol AnalyticScreenProvider {
    var screen: AnalyticScreen { get }
}

extension UIViewController {
    
    @objc
    func tracked_viewWillAppear(_ animated: Bool) {
        if let screenProvider = self as? AnalyticScreenProvider {
            let container = SwinjectStoryboard.defaultContainer
            let tracker = container.resolve(AnalyticsManager.self)
            tracker?.track(screen: screenProvider.screen)
        }
        
        tracked_viewWillAppear(animated)
    }
    
    static func swizzleViewWillAppear() {
        let originalSelector = #selector(UIViewController.viewWillAppear(_:))
        let swizzledSelector = #selector(UIViewController.tracked_viewWillAppear(_:))
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }
}
