//
//  ProductCollectionViewCell.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import AlamofireImage

final class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    func configure(with viewModel: ProductCellViewModel) {
        configureImageView(with: viewModel)
        
        titleLabel.attributedText = viewModel.title
        priceLabel.text = viewModel.price
        cityLabel.text = viewModel.city
    }
}

// MARK: - Private

private extension ProductCollectionViewCell {
    
    func configureImageView(with viewModel: ProductCellViewModel) {
        let placeholder = viewModel.placeholderImage
        
        guard let url = viewModel.imageURL else {
            imageView.image = placeholder
            return
        }
        
        imageView.af_setImage(withURL: url, placeholderImage: placeholder)
    }
}
