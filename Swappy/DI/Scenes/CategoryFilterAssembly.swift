//
//  CategoryFilterAssembly.swift
//  Swappy
//
//  Created by Mihail on 19/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class CategoryFilterAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CategoryFilterPresenter.self) { (r, view: CategoryFilterViewController) in
            return CategoryFilterPresenterImp(
                view: view,
                service: r.resolve()
            )
        }
        
        container.storyboardInitCompleted(CategoryFilterViewController.self) { (r, viewController) in
            viewController.presenter = r.resolve(argument: viewController)
        }
    }
}
