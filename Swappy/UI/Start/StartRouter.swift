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
    
    
}

extension StartRouterImp: StartRouter {
    
    func showMainScreen() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
