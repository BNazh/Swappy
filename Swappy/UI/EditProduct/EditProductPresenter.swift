//
//  AddProductPresenter.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

enum EditProductInitState {
    case
    add,
    edit(product: Product)
}

protocol EditProductPresenter: class {
    
    var screenTitle: String { get }
    var buttonTitle: String { get }
    var categoryItems: [String] { get }
    var cityItems: [String] { get }
    
    func initialize()
    func performProductAction(productRO: ProductRO)
    
    func setState(_ state: EditProductInitState)
}

final class EditProductPresenterImp {
    
    // MARK: - Properties
    
    private unowned let view: EditProductView
    private let productService: ProductService
    
    private var state = EditProductInitState.add
    
    // MARK: - Init
    
    init(view: EditProductView, productService: ProductService) {
        self.view = view
        self.productService = productService
    }
}

// MARK: - Presenter

extension EditProductPresenterImp: EditProductPresenter {
    
    var screenTitle: String {
        return isProductNew ? "Разместить товар" : "Изменить описание"
    }
    
    var buttonTitle: String {
        return isProductNew ? "Готово" : "Изменить"
    }
    
    var categoryItems: [String] {
        return []
    }
    
    var cityItems: [String] {
        return ["Москва", "Санкт-Петербург"]
    }
    
    func initialize() {
        switch state {
        case .add:
            break
        case .edit(product: let product):
            let viewModel = EditProductViewModel(product: product)
            view.showProduct(viewModel: viewModel)
        }
    }
    
    func performProductAction(productRO: ProductRO) {
        guard check(productRO: productRO) else {
            return
        }
    
        var productRO = productRO
        productRO.id = productId
        
        view.showLoading()
        
        productService.addProduct(productRO, isNew: isProductNew) { [weak self] result in
            self?.view.hideLoading()
            
            self?.handleAddProductActionResult(result)
        }
    }
    
    func setState(_ state: EditProductInitState) {
        self.state = state
    }
}

private extension EditProductPresenterImp {
    
    var isProductNew: Bool {
        switch state {
        case .add:
            return true
        case .edit:
            return false
        }
    }
    
    var productId: String? {
        switch state {
        case .add:
            return nil
        case .edit(let product):
            return product.id
        }
    }
    
    func handleAddProductActionResult(_ result: Result<Product>) {
        switch result {
        case .success(let product):
            view.close()
            
        case .failure:
            let message = isProductNew ? "Не удалось создать объявление" : "Не удалось изменить объявление"
            view.showError(message: message)
        }
    }
    
    func check(productRO: ProductRO) -> Bool {
        guard !productRO.name.isEmpty else {
            view.showError(message: "Заполните название продукта")
            return false
        }
        
        guard !productRO.images.isEmpty else {
            view.showError(message: "Добавьте хотя бы одно изображение")
            return false
        }
        
        return true
    }
}
