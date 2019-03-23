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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SwinjectStoryboard.setup()
        IQKeyboardManager.shared.enable = true
        
        setupUIBarButtonApperance()
        
        window?.rootViewController?.modalPresentationStyle = .currentContext
        
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
}

private func setupUIBarButtonApperance() {
//    let appearance = UIBarButtonItem.appearance()
//    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
//    
//    appearance.setTitleTextAttributes(attributes, for: .normal)
//    appearance.setTitleTextAttributes(attributes, for: .highlighted)
}
