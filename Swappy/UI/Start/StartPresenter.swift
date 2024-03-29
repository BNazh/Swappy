//
//  StartPresenter.swift
//  Swappy
//
//  Created by Mihail on 22/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol StartPresenter: class {
    func loadStartData()
}

final class StartPresenterImp {
    
    // MARK: - Properties
    
    private unowned let view: StartView
    private let router: StartRouter
    private let categoryService: CategoryService
    
    // MARK: - Init
    
    init(view: StartView, router: StartRouter, categoryService: CategoryService) {
        self.view = view
        self.router = router
        self.categoryService = categoryService
    }
}

extension StartPresenterImp: StartPresenter {
    
    func loadStartData() {
        var isSuccess = true
        let group = DispatchGroup()
        
        group.enter()
        categoryService.updateCategoryList { result in
            isSuccess = isSuccess && result.isSuccess
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.view.stopLoading()
            
            if isSuccess {
                self?.router.showMainScreen()
            } else {
                self?.view.showError()
            }
        }
    }
}
