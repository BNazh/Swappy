//
//  ProductCollectionViewCell.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import SDWebImage

final class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
    }
    
    // MARK - Functions
    
    func configure(with viewModel: ProductCellViewModel) {
        titleLabel.attributedText = viewModel.title
        priceLabel.text = viewModel.price
        
        imageView.sd_setImage(with: viewModel.imageURL)
        
        setupShadows()
    }
}

private extension ProductCollectionViewCell {
    
    func setupShadows() {
        
        layer.cornerRadius = 16
        layer.masksToBounds = false
        
        let shadowRect = CGRect(x: -2, y: -2, width: bounds.width + 4, height: bounds.height + 4)
        containerView.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.1
    }
}
