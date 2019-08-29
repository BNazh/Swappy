//
//  ProductDetailPresenter.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 11/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol ProductDetailPresenter {
    func setInitState(product: Product, isOwner: Bool)
    
    func onViewDidLoad()
    func setFavorite()
    func showSeller()
    func showUpdateProduct()
    func deleteProduct()
}

final class ProductDetailPresenterImp {
    
    unowned let view: ProductDetailView
    let router: ProductDetailRouter
    let productService: ProductService
    let categoryService: CategoryService
    let favoritesService: FavoritesService
    let tracker: AnalyticsManager
    
    var product: Product!
    var isOwner: Bool = false
    
    init(view: ProductDetailView,
         router: ProductDetailRouter,
         productService: ProductService,
         categoryService: CategoryService,
         favoritesService: FavoritesService,
         tracker: AnalyticsManager) {
        self.view = view
        self.router = router
        self.productService = productService
        self.categoryService = categoryService
        self.favoritesService = favoritesService
        self.tracker = tracker
    }
}

extension ProductDetailPresenterImp: ProductDetailPresenter {
    
    func setInitState(product: Product, isOwner: Bool) {
        self.product = product
        self.isOwner = isOwner
    }
    
    func onViewDidLoad() {
        showProduct()
        setActions()
        
        favoritesService.addSetFavoriteObserver(self)
    }
    
    func showProduct() {
        let category = categoryService.category(withId: product.category)
        let categoryName = category?.name ?? ""
        let isFavorite = favoritesService.isFavorite(product.id)
        
        let viewModel = ProductViewModel(
            product: product,
            categoryName: categoryName,
            isFavorite: isFavorite
        )
        
        view.showProduct(viewModel: viewModel)
    }
    
    func showSeller() {
        tracker.track(event: .contactInfoClick)
        
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
    
    func setFavorite() {
        let id = product.id
        let newIsFavorite = !favoritesService.isFavorite(id)
        favoritesService.setFavorite(newIsFavorite, for: id) { [weak self] result in
            switch result {
            case .success:
                break
            case .failure:
                let message = "Не удалось обновить товар."
                self?.view.showError(message: message)
            }
        }
    }
}

extension ProductDetailPresenterImp: FavoritesObserver {
    
    func didChangeFavorite(_ isFavorite: Bool, for productId: String) {
        showProduct()
    }
}

private extension ProductDetailPresenterImp {
    
    func handleDeleteProduct(result: Result<Void>) {
        switch result {
        case .success:
            router.close()
        case .failure:
            view.showError(message: "Не удалось удалить объявление")
        }
    }
}
