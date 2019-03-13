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
        container.register(ProductDetailPresenter.self) { (resolver, view: ProductDetailViewController) in
            ProductDetailPresenterImp(view: view)
        }
        
        container.storyboardInitCompleted(ProductDetailViewController.self) { (resolver, viewController) in
            viewController.presenter = resolver.resolve(ProductDetailPresenter.self, argument: viewController)
        }
    }
}
