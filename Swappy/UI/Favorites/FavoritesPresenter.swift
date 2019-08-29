//
//  FavoritesPresenter.swift
//  Swappy
//
//  Created by Mihail on 27/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

protocol FavoritesPresenter {
    
    func refreshFavorites()
    func openProduct(with productId: String)
}


final class FavoritesPresenterImp {
    
    // MARK: - Properties
    
    private unowned let view: FavoritesView
    private let router: FavoritesRouter
    private let favoritesService: FavoritesService
    
    private var favoriteProducts = [Product]()
    
    // MARK: - Init
    
    init(view: FavoritesView,
         router: FavoritesRouter,
         favoritesService: FavoritesService) {
        self.view = view
        self.router = router
        self.favoritesService = favoritesService
    }
}

// MARK: - FavoritesPresenter

extension FavoritesPresenterImp: FavoritesPresenter {
    
    func refreshFavorites() {
        favoritesService.getFavoriteProducts { [weak self] result in
            switch result {
            case .success(let favoriteProducts):
                self?.favoriteProducts = favoriteProducts
                self?.reloadView()
            case .failure:
                let message = "Не удалось загрузить избранные товары. Попробуйте позже"
                self?.view.showError(message: message)
                self?.view.endRefreshing()
            }
        }
    }
    
    func openProduct(with productId: String) {
        guard let product = productById(productId) else {
            return
        }
        
        router.openProductDetail(product: product)
    }
}

// MARK: - ProductFavoriteDelegate

extension FavoritesPresenterImp: FavoritesObserver {
    
    func didChangeFavorite(_ isFavorite: Bool, for productId: String) {
        
    }
}

// MARK: - Private

private extension FavoritesPresenterImp {
    
    func reloadView() {
        let cellModels = favoriteProducts.map { product in
            ProductCellViewModel(product)
        }
        
        view.displayCells(cellModels)
    }
    
    func removeProduct(with id: String) {
        favoriteProducts.removeAll { $0.id == id }
        
        view.removeCell(with: id)
    }
    
    func handleSetFavoriteError() {
        reloadView()
        let message = "Не удалось убрать продукт из избранного."
        view.showError(message: message)
    }
    
    func productById(_ id: String) -> Product? {
        return favoriteProducts.first { $0.id == id }
    }
}
