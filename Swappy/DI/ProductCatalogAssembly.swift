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
        
        container.register(ProductCatalogPresenter.self) { (resolver, view: ProductCatalogViewController) in
            return ProductCatalogPresenterImp(
                view: view,
                productWorker: resolver.resolve(ProductCatalogWorker.self)!
            )
        }
        
        container.storyboardInitCompleted(ProductCatalogViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(ProductCatalogPresenter.self, argument: controller)!
        }
    }
}
