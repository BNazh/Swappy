//
//  SelectionItemSelectionPresenter.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol SingleSelectionDelegate: class {
    
    func didSelectItem(_ item: SelectionItem)
}

protocol SingleSelectionPresenter: class {
    
    // MARK: - Functions
    
    func setup(delegate: SingleSelectionDelegate, input: SingleSelectionInput)
    
    func initialize()
    func showItems()
    func selectItem(at index: Int)
    func saveSelectedItem()
}

final class SingleSelectionPresenterImp {
    
    // MARK: - Properties
    
    private unowned let view: SingleSelectionView
    
    private var items: [SelectionItem] = []
    private var selectedItem: SelectionItem?
    private var buttonTitle = ""
    private var title = ""
    
    private weak var delegate: SingleSelectionDelegate?
    
    // MARK: - Init
    
    init(view: SingleSelectionView) {
        self.view = view
    }
}

// MARK: - SingleSelectionPresenter

extension SingleSelectionPresenterImp: SingleSelectionPresenter {

    func setup(delegate: SingleSelectionDelegate, input: SingleSelectionInput) {
        self.delegate = delegate
        self.selectedItem = input.selectedItem
        self.items = input.items
        self.title = input.title
        self.buttonTitle = input.buttonTitle
    }
    
    func initialize() {
        view.displayInitialize(title: title, buttonTitle: buttonTitle)
    }
    
    func showItems() {
        let cellModels = items.map { cellModel(from: $0) }
        
        view.displayItems(cellModels)
    }
    
    func selectItem(at index: Int) {
        selectedItem = items[index]
    }
    
    func saveSelectedItem() {
        guard let selectedItem = selectedItem else { return }
        
        delegate?.didSelectItem(selectedItem)
    }
}

// MARK: - Private

private extension SingleSelectionPresenterImp {
    
    func cellModel(from item: SelectionItem) -> SelectionItemViewModel {
        let id = item.selectionId
        let isSelected = id == selectedItem?.selectionId
        let icon = isSelected ? #imageLiteral(resourceName: "radiobutton_on") : #imageLiteral(resourceName: "radiobutton_off")
        
        return SelectionItemViewModel(
            id: id,
            name: item.selectionTitle,
            icon: icon,
            isSelected: isSelected
        )
    }
}
