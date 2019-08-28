//
//  FavoritesAssembly.swift
//  Swappy
//
//  Created by Mihail on 28/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class FavoritesAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(FavoritesRouter.self) { (resolver, viewController: FavoritesViewController) in
            return FavoritesRouterImp(
                viewController: viewController
            )
        }
        
        container.register(FavoritesPresenter.self) { (resolver, viewController: FavoritesViewController) in
            return FavoritesPresenterImp(
                view: viewController,
                router: resolver.resolve(argument: viewController),
                favoritesService: resolver.resolve()
            )
        }
        
        container.storyboardInitCompleted(FavoritesViewController.self) { (resolver, controller) in
            
            controller.presenter = resolver.resolve(FavoritesPresenter.self, argument: controller)!
        }
    }
}
