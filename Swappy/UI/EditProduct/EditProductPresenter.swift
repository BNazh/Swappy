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
    var cityItems: [String] { get }
    var selectedCategoryName: String { get }
    
    func initialize()
    func performProductAction(productRO: ProductRO)
    func openCategorySelection()
    
    func setState(_ state: EditProductInitState)
}

final class EditProductPresenterImp {
    
    // MARK: - Properties
    
    private unowned let view: EditProductView
    private let router: EditProductRouter
    private let productService: ProductService
    private let categoryService: CategoryService
    private let tracker: AnalyticsManager
    
    private var state = EditProductInitState.add
    private var selectedCategory: Category?
    
    // MARK: - Init
    
    init(view: EditProductView, router: EditProductRouter, productService: ProductService, categoryService: CategoryService, tracker: AnalyticsManager) {
        self.view = view
        self.router = router
        self.productService = productService
        self.categoryService = categoryService
        self.tracker = tracker
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
    
    var cityItems: [String] {
        return ["Москва", "Санкт-Петербург"]
    }
    
    var selectedCategoryName: String {
        return selectedCategory?.name ?? ""
    }
    
    func initialize() {
        switch state {
        case .add:
            tracker.track(screen: .createProduct)
        case .edit(product: let product):
            selectedCategory = categoryService.category(withId: product.category)
            
            let viewModel = EditProductViewModel(
                product: product,
                categoryName: selectedCategoryName
            )
            view.showProduct(viewModel: viewModel)
        }
    }
    
    func performProductAction(productRO: ProductRO) {
        guard check(productRO: productRO) else {
            return
        }
    
        var productRO = productRO
        productRO.id = productId
        productRO.category = selectedCategory?.id ?? ""
        
        view.showLoading()
        
        productService.addProduct(productRO, isNew: isProductNew) { [weak self] result in
            self?.view.hideLoading()
            
            self?.handleAddProductActionResult(result)
        }
    }
    
    func openCategorySelection() {
        let input = SingleSelectionInput(
            items: categoryService.categories,
            selectedItem: selectedCategory,
            title: "Категория",
            buttonTitle: "Сохранить"
        )
            
        router.openCategorySelection(delegate: self,
                                     input: input)
    }
    
    func setState(_ state: EditProductInitState) {
        self.state = state
    }
}

extension EditProductPresenterImp: SingleSelectionDelegate {
    
    func didSelectItem(_ item: SelectionItem) {
        guard let category = item as? Category else { return }
        selectedCategory = category
        view.selectCategory(category.name)
    }
}

// MARK: - Private

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
        case .success:
            view.close()
            tracker.track(event: .addProductSuccess)
            
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
        
        guard selectedCategory != nil else {
            view.showError(message: "Выберите категорию товара")
            return false
        }
        
        return true
    }
}
