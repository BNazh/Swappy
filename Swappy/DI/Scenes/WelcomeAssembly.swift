//
//  WelcomeAssembly.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class WelcomeAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(WelcomeRouter.self) { (r, viewContoller: WelcomeViewController) in
            return WelcomeRouterImp(viewController: viewContoller)
        }
        
        container.register(WelcomePresenter.self) { (r, view: WelcomeViewController) in
            return WelcomePresenterImp(
                view: view,
                router: r.resolve(argument: view),
                keychainStore: r.resolve(),
                cityService: r.resolve()
            )
        }
        
        container.storyboardInitCompleted(WelcomeViewController.self) { (r, viewController) in
            viewController.presenter = r.resolve(argument: viewController)
        }
    }
}
