//
//  EditProductRouter.swift
//  Swappy
//
//  Created by Mihail on 13/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol EditProductRouter: class {
    func openSingleSelection(delegate: SingleSelectionDelegate,
                             input: SingleSelectionInput)
    
    func showLoginCardIfNeeded()
    func hideLoginCard()
}

final class EditProductRouterImp {
    
    // MARK: - Properties
    
    unowned let viewController: UIViewController
    
    private var loginViewController: UIViewController?
    
    // MARK: - Init
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension EditProductRouterImp: EditProductRouter {
    
    func openSingleSelection(delegate: SingleSelectionDelegate,
                             input: SingleSelectionInput) {
        
        let selectionVC: SingleSelectionViewController
        selectionVC = UIStoryboard.createViewController()
        
        selectionVC.presenter.setup(delegate: delegate, input: input)
        
        let presentationController = viewController.tabBarController
        presentationController?.present(selectionVC, animated: true, completion: nil)
    }
    
    func showLoginCardIfNeeded() {
        guard loginViewController == nil else {
            return
        }
        
        let loginCard: LoginCardViewController = UIStoryboard.createViewController()
        self.loginViewController = loginCard
        
        //loginCard.isClosable = false
        
        let navigationController = viewController.navigationController
        navigationController?.present(loginCard, animated: true, completion: nil)
    }
    
    func hideLoginCard() {
        self.loginViewController?.dismiss(animated: true, completion: nil)
    }
}
