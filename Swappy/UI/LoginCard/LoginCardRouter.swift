//
//  LoginCardRouter.swift
//  Swappy
//
//  Created by Mihail on 14/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol LoginCardRouter: class {
    func openPhoneLogin()
}

final class LoginCardRouterImp {
    
    unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}


extension LoginCardRouterImp: LoginCardRouter {
    
    func openPhoneLogin() {
        
    }
}
