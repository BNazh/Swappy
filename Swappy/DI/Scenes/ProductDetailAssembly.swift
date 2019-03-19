//
//  ProdcutDetailAssembly.swift
//  Swappy
//
//  Created by Mihail on 12/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import SwinjectStoryboard
import Swinject

final class ProductDetailAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProductDetailRouter.self) {
            (resolver, viewController: ProductDetailViewController) in
            
            ProductDetailRouterImp(viewController: viewController)
        }
        
        container.register(ProductDetailPresenter.self) {
            (resolver, view: ProductDetailViewController, router: ProductDetailRouter) in
            
            ProductDetailPresenterImp(view: view, router: router)
        }
        
        container.storyboardInitCompleted(ProductDetailViewController.self) {
            (resolver, viewController) in
            
            let router = resolver.resolve(ProductDetailRouter.self, argument: viewController)!
            
            let presenter = resolver.resolve(ProductDetailPresenter.self,
                                             arguments: viewController, router)
            
            viewController.presenter = presenter
        }
    }
}
