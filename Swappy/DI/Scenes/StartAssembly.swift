//
//  StartAssembly.swift
//  Swappy
//
//  Created by Mihail on 23/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class StartAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(StartRouter.self) { _ in
            return StartRouterImp()
        }
        
        container.register(StartPresenter.self) { (r, view: StartViewController) in
            return StartPresenterImp(
                view: view,
                router: r.resolve(),
                categoryService: r.resolve(),
                cityService: r.resolve(),
                favoritesService: r.resolve(),
                authService: r.resolve(),
                settingsStore: r.resolve()
            )
        }
        
        container.storyboardInitCompleted(StartViewController.self) { (r, viewController) in
            viewController.presenter = r.resolve(argument: viewController)
        }
    }
}
