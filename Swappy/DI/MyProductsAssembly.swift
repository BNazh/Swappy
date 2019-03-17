//
//  MyProductsViewController.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class MyProductsAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(MyProductsRouter.self) { (resolver, viewController: MyProductsViewController) in
            return MyProductsRouterImp(
                viewController: viewController
            )
        }
        
        container.register(MyProductsPresenter.self) { (resolver, viewController: MyProductsViewController) in
            return MyProductsPresenterImp(
                view: viewController,
              //  productWorker: resolver.resolve(ProductCatalogWorker.self)!,
                router: resolver.resolve(MyProductsRouter.self, argument: viewController)!
            )
        }
        
        container.storyboardInitCompleted(MyProductsViewController.self) { (resolver, controller) in
            
            controller.presenter = resolver.resolve(MyProductsPresenter.self, argument: controller)!
            controller.dataDisplayManager = resolver.resolve(ProductsDDM.self)
        }
    }
}
