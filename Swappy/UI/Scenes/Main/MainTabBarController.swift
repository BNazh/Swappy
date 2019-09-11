//
//  MainTabBarController.swift
//  Swappy
//
//  Created by Mihail on 04/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var authService: AuthService!
    
    var profileNavigationController: UINavigationController? {
        return viewControllers?.last as? UINavigationController
    }
    
    var editProductNavigationController: UINavigationController? {
        return viewControllers?[safe: 2] as? UINavigationController
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: не очень
        self.delegate = self
    }
    
    func openLoginCard() {
        let loginVC: LoginCardViewController = UIStoryboard.createViewController()
        
        present(loginVC, animated: true, completion: nil)
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let isEditProduct = viewController == editProductNavigationController
        let notAuthorized = !authService.isAuthorized
        
        if notAuthorized, isEditProduct {
            openLoginCard()
            return false
        }
        
        return true
    }
}

// MARK: - Private

private extension MainTabBarController {
    
    
}


extension UIViewController {
    
    var mainTabBarController: MainTabBarController? {
        let delegate = UIApplication.shared.appDelegate
        let root = delegate?.window?.rootViewController
        let tabBarController = root as? MainTabBarController
        
        return tabBarController
    }
}
