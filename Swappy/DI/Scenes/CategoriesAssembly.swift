//
//  CategoriesAssembly.swift
//  Swappy
//
//  Created by Mihail on 31/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class CategoriesAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(CategoriesRouter.self) { (resolver, viewController: CategoriesViewController) in
            return CategoriesRouterImp(
                viewController: viewController
            )
        }
        
        container.register(CategoriesPresenter.self) { (resolver, viewController: CategoriesViewController) in
            return CategoriesPresenterImp(
                view: viewController,
                router: resolver.resolve(argument: viewController),
                categoryService: resolver.resolve()
            )
        }
        
        container.storyboardInitCompleted(CategoriesViewController.self) { (resolver, controller) in
            
            controller.presenter = resolver.resolve(CategoriesPresenter.self, argument: controller)!
        }
    }
}
