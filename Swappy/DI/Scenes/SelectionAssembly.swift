//
//  SelectionAssembly.swift
//  Swappy
//
//  Created by Mihail on 13/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class SelectionAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CategorySelectionPresenter.self) { (r, view: CategorySelectionViewController) in
            return CategorySelectionPresenterImp(
                view: view
            )
        }
        
        container.storyboardInitCompleted(CategorySelectionViewController.self) { (r, viewController) in
            viewController.presenter = r.resolve(argument: viewController)
        }
    }
}
