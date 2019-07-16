//
//  WelcomeRouter.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol WelcomeRouter {
    
    func openSelection(delegate: SingleSelectionDelegate,
                       input: SingleSelectionInput)
    
    func openMainScreen()
}

final class WelcomeRouterImp {
    
    unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - WelcomeRouter

extension WelcomeRouterImp: WelcomeRouter {
    
    func openMainScreen() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func openSelection(delegate: SingleSelectionDelegate,
                       input: SingleSelectionInput) {
        
        let controller: SingleSelectionViewController
        controller = UIStoryboard.createViewController()
        
        controller.presenter.setup(delegate: delegate, input: input)
        
        viewController.present(controller, animated: true, completion: nil)
    }
}
