//
//  ProductDetailPresenter.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 11/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProductDetailPresenter {
    func setInitState(product: Product, isOwner: Bool)
    
    func setActions()
    func showProduct()
    func showSeller()
    func showUpdateProduct()
    
    func deleteProduct()
}

final class ProductDetailPresenterImp {
    
    unowned let view: ProductDetailView
    let router: ProductDetailRouter
    let productService: ProductService
    
    var product: Product!
    var isOwner: Bool = false
    
    init(view: ProductDetailView,
         router: ProductDetailRouter,
         productService: ProductService) {
        self.view = view
        self.router = router
        self.productService = productService
    }
}

extension ProductDetailPresenterImp: ProductDetailPresenter {
    
    func setInitState(product: Product, isOwner: Bool) {
        self.product = product
        self.isOwner = isOwner
    }
    
    func showProduct() {
        let viewModel = ProductViewModel(product: product)
        view.showProduct(viewModel: viewModel)
    }
    
    func showSeller() {
        router.openSeller(product: product)
    }
    
    func showUpdateProduct() {
        router.openProductEdit(product: product)
    }
    
    func deleteProduct() {
        view.showLoading()
        
        productService.deleteProduct(id: product.id) { [weak self] result in
            self?.view.hideLoading()
            self?.handleDeleteProduct(result: result)
        }
    }
    
    func setActions() {
        view.displayActionSettings(isSellerButtonHidden: isOwner, isEditViewHidden: !isOwner)
    }
}

private extension ProductDetailPresenterImp {
    
    func handleDeleteProduct(result: Result<Bool>) {
        switch result {
        case .success:
            router.close()
        case .failure:
            view.showError(message: "Не удалось удалить объявление")
        }
    }
}
