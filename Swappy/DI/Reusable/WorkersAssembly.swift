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
        container.register(ProductCatalogWorker.self) { _ in
            return ProductCatalogWorkerImp()
        }
        
        container.register(ProductsDDM.self) { _ in
            return ProductsDDMImp()
        }
    }
}
