//
//  PhoneLoginRouter.swift
//  Swappy
//
//  Created by Mihail on 20/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol PhoneLoginRouter: class {
    
    func openCodeConfirmation(phone: String)
}

final class PhoneLoginRouterImp {
    
    unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension PhoneLoginRouterImp: PhoneLoginRouter {
    
    func openCodeConfirmation(phone: String) {
        let storyboardName = PhoneLoginViewController.storyboardName
        let codeController: CodeConfirmationViewController
        codeController = UIStoryboard.createViewController(storyboardName: storyboardName)
        
        codeController.presenter.setPhone(phone)
        
        viewController.navigationController?.pushViewController(codeController, animated: true)
    }
}
