//
//  Swinject.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc
    class func setup() {
        let assembler = Assembler(container: defaultContainer)
        assembler.apply(assemblies: [
            ServicesAssembly(),
            
            ProductCatalogAssembly(),
            ProductDetailAssembly(),
            EditProductAssembly(),
            SellerInfoAssembly(),
            MyProductsAssembly(),
            PhoneLoginAssembly(),
            CodeConfirmationAssembly(),
            LoginCardAssembly(),
            SelectionAssembly(),
            CategoryFilterAssembly()
        ])
        
        Container.loggingFunction = nil
    }
}
