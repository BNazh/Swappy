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
        
        container.register(DatabaseStore.self) { _ in
            RealmStore()
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
        
        container.register(MoyaProvider<CategoryTarget>.self) { r in
            BaseProvider<CategoryTarget>(keychainStore: r.resolve())
        }
        
        container.register(MoyaProvider<UserTarget>.self) { r in
            BaseProvider<UserTarget>(keychainStore: r.resolve())
        }
        
        container.register(MoyaProvider<FavoritesTarget>.self) { r in
            BaseProvider<FavoritesTarget>(keychainStore: r.resolve())
        }
        
        container.register(MoyaProvider<SearchTarget>.self) { r in
            BaseProvider<SearchTarget>(keychainStore: r.resolve())
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
                keychainStore: r.resolve(KeychainStore.self)!,
                databaseStore: r.resolve(DatabaseStore.self)!
            )
        }
        
        container.register(ImageService.self) { r in
            return ImageServiceImp(
                provider: r.resolve(MoyaProvider<ImageTarget>.self)!
            )
        }
        
        container.register(CityService.self) { r in
            return CityServiceImp(
                settingsStore: r.resolve()
            )
        }
        
        container.register(UserService.self) { r in
            UserServiceImp(
                keychain: r.resolve(),
                database: r.resolve(),
                provider: r.resolve()
            )
        }
        
        container.register(FavoritesService.self) { r in
            FavoritesServiceImp(
                provider: r.resolve(),
                productService: r.resolve(),
                keychainStore: r.resolve()
            )
        }.inObjectScope(.container)
        
        container.register(VKService.self) { r in
            return VKServiceImp(tracker: r.resolve())
        }.inObjectScope(.container)
        
        container.register(FBService.self) { r in
            return FBServiceImp()
        }.inObjectScope(.container)
        
        container.register(CategoryService.self) { r in
            return CategoryServiceImp(provider: r.resolve())
        }.inObjectScope(.container)
        
        // Managers
        
        container.register(AnalyticsManager.self) { r in
            return AnalyticsManagerImp()
        }.inObjectScope(.container)
        
        container.register(PushNotificationService.self) { r in
            return PushNotificationServiceImp()
        }.inObjectScope(.container)
        
        container.register(AppsFlyerManager.self) { r in
            return AppsFlyerManager()
        }.inObjectScope(.container)
        
        // DDM
        
        container.register(ProductsDDM.self) { _ in
            return ProductsDDMImp()
        }
    }
}
