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
    var categoryItems: [String] { get }
    
    func initialize()
    func createProduct(_ productRO: ProductRO)
    
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
        switch state {
        case .add:
            return "Разместить товар"
        case .edit:
            return "Изменить описание"
        }
    }
    
    var categoryItems: [String] {
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
    
    func createProduct(_ productRO: ProductRO) {
        view.showLoading()
        
        productService.createProduct(productRO) { [weak self] result in
            self?.view.hideLoading()
            
            print(result.isSuccess)
        }
    }
    
    func setState(_ state: EditProductInitState) {
        self.state = state
    }
}
