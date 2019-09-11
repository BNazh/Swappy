//
//  SellerInfoPresenter.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol SellerInfoPresenter: AnyObject {
    
    func setProduct(_ product: Product)
    func showSeller()
}

final class SellerInfoPresenterImp {
    
    // MARK: - Properties
    
    unowned let view: SellerInfoView
    var product: Product!
    
    // MARK: - Init
    
    init(view: SellerInfoView) {
        self.view = view
    }
}

// MARK: - SellerInfoPresenter

extension SellerInfoPresenterImp: SellerInfoPresenter {
    
    func setProduct(_ product: Product) {
        self.product = product
    }
    
    func showSeller() {
        guard let seller = product.seller else {
            return
        }
        
        let viewModel = SellerInfoViewModel(
            seller: seller,
            contactPhone: product.contactPhone
        )
        
        view.displaySeller(viewModel: viewModel)
    }
}
