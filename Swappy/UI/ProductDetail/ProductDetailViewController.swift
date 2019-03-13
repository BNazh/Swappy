//
//  ProductDetailViewController.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProductDetailView {
    func showProduct(viewModel: ProductViewModel)
}

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var imageSlider: ImageSlider!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: ProductDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        presenter.showProduct()
    }
    
    @IBAction func openSellerTouchedDown(_ sender: UIButton) {
        print("open seller tapped")
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        print("close tapepd tapped")
        dismiss(animated: true, completion: nil)
    }
}

extension ProductDetailViewController: ProductDetailView {
    
    func showProduct(viewModel: ProductViewModel) {
        imageSlider.setImageUrls(viewModel.imageUrls)
        
        titleLabel.attributedText = viewModel.title
        priceLabel.text = viewModel.price
        descriptionLabel.text = viewModel.description
    }
}

private extension ProductDetailViewController {
    
    func setup() {
        imageSlider.roundCorners(corners: [.topLeft, .topRight], radius: 16)
    }
}
