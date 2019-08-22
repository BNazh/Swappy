//
//  MainAssembly.swift
//  Swappy
//
//  Created by Mihail on 22/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class MainAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.storyboardInitCompleted(MainTabBarController.self) { (r, viewController) in
            viewController.authService = r.resolve()
        }
    }
}
