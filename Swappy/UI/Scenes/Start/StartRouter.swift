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
    func showWelcomeScreen()
}

final class StartRouterImp {
}

extension StartRouterImp: StartRouter {
    
    func showMainScreen() {
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        
        UIApplication.shared.keyWindow?.rootViewController = rootController
    }
    
    func showWelcomeScreen() {
        let welcomeController: WelcomeViewController
        welcomeController = UIStoryboard.createViewController()
        
        let rootController = UIApplication.shared.keyWindow?.rootViewController
        
        rootController?.present(welcomeController, animated: true, completion: nil)
    }
}
