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
        container.register(SingleSelectionPresenter.self) { (r, view: SingleSelectionViewController) in
            return SingleSelectionPresenterImp(
                view: view
            )
        }
        
        container.storyboardInitCompleted(SingleSelectionViewController.self) { (r, viewController) in
            viewController.presenter = r.resolve(argument: viewController)
        }
    }
}
