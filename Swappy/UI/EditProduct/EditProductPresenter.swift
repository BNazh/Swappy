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
    
    func initialize()
    
    func setState(_ state: EditProductInitState)
}

final class EditProductPresenterImp {
    
    // MARK: - Properties
    
    private unowned let view: EditProductView
    
    private var state = EditProductInitState.add
    
    // MARK: - Init
    
    init(view: EditProductView) {
        self.view = view
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
    
    func initialize() {
        
        switch state {
            
        case .add:
            break
            
        case .edit(product: let product):
            let viewModel = EditProductViewModel(product: product)
            view.showProduct(viewModel: viewModel)
            
        }
    }
    
    func setState(_ state: EditProductInitState) {
        self.state = state
    }
}
