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
        
        container.storyboardInitCompleted(ProductCata, initCompleted: <#T##(Resolver, C) -> ()#>)
    }
}
