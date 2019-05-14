//
//  LoginCardAssembly.swift
//  Swappy
//
//  Created by Mihail on 05/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class LoginCardAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(LoginCardViewController.self) { (r, viewController) in
            viewController.tracker = r.resolve()
            viewController.vkService = r.resolve()
            viewController.fbService = r.resolve()
            viewController.authService = r.resolve()
        }
    }
}
