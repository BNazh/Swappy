//
//  AddProductPresenter.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

enum InitState {
    case
    add,
    edit(product: Product)
}

protocol EditProductPresenter: class {
    
    func initialize()
}

final class EditProductPresenterImp {
    
}


