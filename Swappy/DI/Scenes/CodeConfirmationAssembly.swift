//
//  CodeConfirmationAssembly.swift
//  Swappy
//
//  Created by Mihail on 21/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class CodeConfirmationAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(CodeConfirmationPresenter.self) { (resolver, view: CodeConfirmationViewController) in
            return CodeConfirmationPresenterImp(
                view: view,
                authService: resolver.resolve(AuthService.self)!
            )
        }
        
        container.storyboardInitCompleted(CodeConfirmationViewController.self) { (resolver, viewController) in
            let presenter = container.resolve(CodeConfirmationPresenter.self, argument: viewController)!
            
            viewController.presenter = presenter
        }
    }
}
