//
//  EditProductRouter.swift
//  Swappy
//
//  Created by Mihail on 13/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol EditProductRouter: class {
    func openCategorySelection(delegate: CategorySelectionDelegate,
                               items: [String],
                               selectedItem: CategoryName)
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
    
    func openCategorySelection(delegate: CategorySelectionDelegate,
                               items: [String],
                               selectedItem: CategoryName) {
        
        let selectionVC: CategorySelectionViewController
        selectionVC = UIStoryboard.createViewController()
        
        selectionVC.presenter.delegate = delegate
        selectionVC.presenter.selectedCategory = selectedItem
        // TODO: sellerVC.items = items
        
        viewController.present(selectionVC, animated: true, completion: nil)
    }
}
