//
//  SellerInfoAssembly.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import SwinjectStoryboard
import Swinject

final class SellerInfoAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SellerInfoPresenter.self) { (resolver, view: SellerInfoViewController) in
            SellerInfoPresenterImp(view: view)
        }
        
        container.storyboardInitCompleted(SellerInfoViewController.self) { (resolver, viewController) in
            viewController.presenter = resolver.resolve(SellerInfoPresenter.self, argument: viewController)
        }
    }
}
