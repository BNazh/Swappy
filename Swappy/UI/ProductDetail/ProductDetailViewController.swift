//
//  ProductDetailViewController.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ProductDetailView: class, ErrorView, LoadingView {
    func showProduct(viewModel: ProductViewModel)
}

class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailPresenter!

    @IBOutlet weak var imageSlider: ImageSlider!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.showProduct()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func openSellerTouchedDown(_ sender: UIButton) {
        presenter.showSeller()
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateProductTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteProductTapped(_ sender: UIButton) {
        
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
        imageSlider.roundCorners(corners: [.topRight, .topLeft], radius: 16)
    }
}
