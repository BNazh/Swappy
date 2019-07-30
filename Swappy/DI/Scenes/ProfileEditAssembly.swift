//
//  ProfileEditAssembly.swift
//  Swappy
//
//  Created by Mihail on 30/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class ProfileEditAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(ProfileEditRouter.self) { (resolver, viewController: ProfileEditViewController) in
            return ProfileEditRouterImp(
                viewController: viewController
            )
        }
        
        container.register(ProfileEditPresenter.self) { (resolver, viewController: ProfileEditViewController) in
            return ProfileEditPresenterImp(
                view: viewController,
                router: resolver.resolve(argument: viewController),
                userService: resolver.resolve(),
                imageService: resolver.resolve(),
                cityService: resolver.resolve()
            )
        }
        
        container.storyboardInitCompleted(ProfileEditViewController.self) { (resolver, controller) in
            
            controller.presenter = resolver.resolve(ProfileEditPresenter.self, argument: controller)!
        }
    }
}
