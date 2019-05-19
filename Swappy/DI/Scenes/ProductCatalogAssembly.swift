//
//  ProductCatalogAssembly.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class ProductCatalogAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(ProductCatalogRouter.self) { (resolver, viewController: ProductCatalogViewController) in
            return ProductCatalogRouterImp(
                viewController: viewController
            )
        }
        
        container.register(ProductCatalogPresenter.self) { (resolver, viewController: ProductCatalogViewController) in
            return ProductCatalogPresenterImp(
                view: viewController,
                productService: resolver.resolve(),
                categoryService: resolver.resolve(),
                router: resolver.resolve(ProductCatalogRouter.self, argument: viewController)!,
                tracker: resolver.resolve()
            )
        }
        
        container.storyboardInitCompleted(ProductCatalogViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(ProductCatalogPresenter.self, argument: controller)!
            controller.dataDisplayManager = resolver.resolve(ProductsDDM.self)
        }
    }
}
