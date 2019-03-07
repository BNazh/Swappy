//
//  ProductCatalogPresenter.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProductCatalogPresenter {
    
    func viewDidLoad()
    func loadProducts()
}

final class ProductCatalogPresenterImp {
    
    unowned let view: ProductCatalogView
    let productWorker: ProductCatalogWorker
    
    init(view: ProductCatalogView, productWorker: ProductCatalogWorker) {
        self.view = view
        self.productWorker = productWorker
    }
}

extension ProductCatalogPresenterImp: ProductCatalogPresenter {
    
    func viewDidLoad() {
        productWorker.getProducts { (<#Result<[Product]>#>) in
            <#code#>
        }
    }
    
    func loadProducts() {
        <#code#>
    }
}
