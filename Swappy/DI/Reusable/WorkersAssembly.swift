//
//  WorkersAssembly.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

final class WorkersAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(ProductCatalogService.self) { _ in
            return ProductCatalogServiceImp()
        }
        
        container.register(AuthService.self) { _ in
            return AuthServiceImp()
        }
        
        container.register(ProductsDDM.self) { _ in
            return ProductsDDMImp()
        }
    }
}

