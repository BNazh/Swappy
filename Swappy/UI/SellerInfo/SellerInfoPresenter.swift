//
//  SellerInfoPresenter.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol SellerInfoPresenter: class {
    func setProduct(_ product: Product)
    func showSeller()
}

final class SellerInfoPresenterImp {
    unowned let view: SellerInfoView
    var product: Product!
    
    init(view: SellerInfoView) {
        self.view = view
    }
}

extension SellerInfoPresenterImp: SellerInfoPresenter {
    
    func setProduct(_ product: Product) {
        self.product = product
    }
    
    func showSeller() {
        let viewModel = SellerInfoViewModel(
            seller: product.seller,
            contactPhone: product.contactPhone
        )
        
        view.displaySeller(viewModel: viewModel)
    }
}
