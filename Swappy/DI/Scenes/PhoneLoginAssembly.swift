//
//  PhoneLoginAssembly.swift
//  Swappy
//
//  Created by Mihail on 20/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class PhoneLoginAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(PhoneLoginRouter.self) { (_, viewController: PhoneLoginViewController) in
            return PhoneLoginRouterImp(viewController: viewController)
        }
        
        container.register(PhoneLoginPresenter.self) { (r, view: PhoneLoginViewController) in
            return PhoneLoginPresenterImp(
                view: view,
                router: r.resolve(),
                authService: r.resolve(),
                tracker: r.resolve()
            )
        }
        
        container.storyboardInitCompleted(PhoneLoginViewController.self) { (resolver, viewController) in
            let presenter = container.resolve(PhoneLoginPresenter.self, argument: viewController)!
            
            viewController.presenter = presenter
        }
    }
}
