//
//  StartPresenter.swift
//  Swappy
//
//  Created by Mihail on 22/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol StartPresenter: class {
    
}

final class StartPresenterImp {
    
    private unowned let view: StartView
    private let router: StartRouter
    private let categoryService: CategoryService
    
    init() {
        
    }
}
