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
        container.register(EditProductPresenter.self) { (r, view: EditProductViewController) in
            return EditProductPresenterImp(
                view: view,
                productService: r.resolve(),
                tracker: r.resolve()
            )
        }
        
        container.storyboardInitCompleted(EditProductViewController.self) { (resolver, viewController) in
            let presenter = container.resolve(EditProductPresenter.self, argument: viewController)!
            
            viewController.presenter = presenter
            viewController.citiesDDM = resolver.resolve(TextFieldPickerDDM.self)!
        }
    }
}
