//
//  EditProductAssembly.swift
//  Swappy
//
//  Created by Mihail on 19/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class EditProductAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(EditProductPresenter.self) { (resolver, view: EditProductViewController) in
            return EditProductPresenterImp(
                view: view,
                productService: resolver.resolve(ProductService.self)!
            )
        }
        
        container.storyboardInitCompleted(EditProductViewController.self) { (resolver, viewController) in
            let presenter = container.resolve(EditProductPresenter.self, argument: viewController)!
            
            viewController.presenter = presenter
            viewController.categoryDDM = resolver.resolve(TextFieldPickerDDM.self)!
        }
    }
}
