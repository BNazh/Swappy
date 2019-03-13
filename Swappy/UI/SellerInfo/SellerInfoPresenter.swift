//
//  SellerInfoPresenter.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

protocol SellerInfoPresenter: class {
    func setSeller(_ seller: Seller)
    func showSeller()
}

final class SellerInfoPresenterImp {
    unowned let view: SellerInfoView
    var seller: Seller!
    
    init(view: SellerInfoView) {
        self.view = view
    }
}

extension SellerInfoPresenterImp: SellerInfoPresenter {
    
    func setSeller(_ seller: Seller) {
        self.seller = seller
    }
    
    func showSeller() {
        let viewModel = SellerInfoViewModel(seller: seller)
        view.displaySeller(viewModel: viewModel)
    }
}
