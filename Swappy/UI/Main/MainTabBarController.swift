//
//  MainTabBarController.swift
//  Swappy
//
//  Created by Mihail on 04/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    var profileNavigationController: UINavigationController? {
        return viewControllers?.last as? UINavigationController
    }
}

extension UIViewController {
    
    var mainTabBarController: MainTabBarController? {
        let delegate = UIApplication.shared.appDelegate
        let root = delegate?.window?.rootViewController
        let tabBarController = root as? MainTabBarController
        
        return tabBarController
    }
}
