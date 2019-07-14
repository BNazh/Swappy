//
//  EditProductRouter.swift
//  Swappy
//
//  Created by Mihail on 13/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol EditProductRouter: class {
    func openCategorySelection(delegate: SingleSelectionDelegate,
                               input: SingleSelectionInput)
}

final class EditProductRouterImp {
    
    // MARK: - Properties
    
    unowned let viewController: UIViewController
    
    // MARK: - Init
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension EditProductRouterImp: EditProductRouter {
    
    func openCategorySelection(delegate: SingleSelectionDelegate,
                               input: SingleSelectionInput) {
        
        let selectionVC: SingleSelectionViewController
        selectionVC = UIStoryboard.createViewController()
        
        selectionVC.presenter.setup(delegate: delegate, input: input)
        
        viewController.present(selectionVC, animated: true, completion: nil)
    }
}
