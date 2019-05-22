//
//  StartRouter.swift
//  Swappy
//
//  Created by Mihail on 22/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol StartRouter: class {
    func showMainScreen()
}

final class StartRouterImp {
    
    // MARK: - Properties
    
    let viewController: UIViewController
    
    // MARK: - Init
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension StartRouterImp: StartRouter {
    
    func showMainScreen() {
        let name = MainViewController.storyboardName
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        let controller = storyboard.instantiateInitialViewController()
        
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
