//
//  WorkersAssembly.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject
import Moya

final class ServicesAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Stores
        
        container.register(KeychainStore.self) { _ in
            KeychainStoreImp()
        }.inObjectScope(.container)
        
        // Targets
        
        container.register(MoyaProvider<AuthTarget>.self) { r in
            BaseProvider<AuthTarget>(keychainStore: r.resolve(KeychainStore.self)!)
        }
        
        container.register(MoyaProvider<ProductsTarget>.self) { r in
            BaseProvider<ProductsTarget>(keychainStore: r.resolve(KeychainStore.self)!)
        }
        
        container.register(MoyaProvider<ImageTarget>.self) { r in
            BaseProvider<ImageTarget>(keychainStore: r.resolve(KeychainStore.self)!)
        }
        
        // Services
        
        container.register(ProductService.self) { r in
            return ProductServiceImp(
                provider: r.resolve(MoyaProvider<ProductsTarget>.self)!,
                keychainStore: r.resolve(KeychainStore.self)!
            )
        }
        
        container.register(AuthService.self) { r in
            return AuthServiceImp(
                provider: r.resolve(MoyaProvider<AuthTarget>.self)!,
                keychainStore: r.resolve(KeychainStore.self)!
            )
        }
        
        container.register(ImageService.self) { r in
            return ImageServiceImp(
                provider: r.resolve(MoyaProvider<ImageTarget>.self)!
            )
        }
        
        // DDM
        
        container.register(ProductsDDM.self) { _ in
            return ProductsDDMImp()
        }
    }
}
