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
import SwiftyVK

import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let analyticManager: AnalyticsManager = SwinjectStoryboard.defaultContainer.resolve()
    let pushManager: PushNotificationService = SwinjectStoryboard.defaultContainer.resolve()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupKeyboardManager()
        setupUIBarButtonApperance()

        
        pushManager.register(application: application)
        
        analyticManager.configure(launchOptions: launchOptions)
        analyticManager.track(event: .startSession)
        UIViewController.swizzleViewWillAppear()
        
        //KeychainStoreImp().accessToken = nil
        
        window?.rootViewController?.modalPresentationStyle = .currentContext
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let app = options[.sourceApplication] as? String
        VK.handle(url: url, sourceApplication: app)
        return true
    }
    
    // MARK: - Core Data Saving support

//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 80
    }
}

private func setupUIBarButtonApperance() {
//    let appearance = UIBarButtonItem.appearance()
//    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
//    
//    appearance.setTitleTextAttributes(attributes, for: .normal)
//    appearance.setTitleTextAttributes(attributes, for: .highlighted)
}
