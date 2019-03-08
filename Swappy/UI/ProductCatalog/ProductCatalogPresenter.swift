//
//  ProductCatalogPresenter.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProductCatalogPresenter {
    
    func loadProducts()
}

final class ProductCatalogPresenterImp {
    
    unowned let view: ProductCatalogView
    let productWorker: ProductCatalogWorker
    
    private var isLoading = false
    
    init(view: ProductCatalogView, productWorker: ProductCatalogWorker) {
        self.view = view
        self.productWorker = productWorker
    }
}

extension ProductCatalogPresenterImp: ProductCatalogPresenter {
    
    func loadProducts() {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        
        productWorker.getProducts { [weak self] result in
            
            self?.isLoading = false
            
            switch result {
            case .success(let products):
                let viewModels = products.map { ProductCellViewModel($0) }
                self?.view.reloadCells(viewModels)
                
            case .failure:
                self?.view.showError(message: "error")
            }
        }
    }
}
