//
//  AppDelegate.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import CoreData

import SwinjectStoryboard
import IQKeyboardManagerSwift
import VK_ios_sdk


import Fabric
import Crashlytics

import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties

    var window: UIWindow?
    
    let analyticManager: AnalyticsManager = SwinjectStoryboard.defaultContainer.resolve()
    let appsFlyerManager: AppsFlyerManager = SwinjectStoryboard.defaultContainer.resolve()
    let pushManager: PushNotificationService = SwinjectStoryboard.defaultContainer.resolve()
    let categoryService: CategoryService = SwinjectStoryboard.defaultContainer.resolve()
    
    // MARK: - Functions

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupKeyboardManager()

        Fabric.with([Crashlytics.self])
        
        appsFlyerManager.setup()
        
        pushManager.register(application: application)
        
        analyticManager.configure(application: application, launchOptions: launchOptions)
        analyticManager.track(event: .startSession)
        UIViewController.swizzleViewWillAppear()
        
        categoryService.updateCategoryList()
        
        //ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        window?.rootViewController?.modalPresentationStyle = .currentContext
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let app = options[.sourceApplication] as? String
        VKSdk.processOpen(url, fromApplication: app ?? "")
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appsFlyerManager.trackAppLaunch()
    }
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 80
    }
}
