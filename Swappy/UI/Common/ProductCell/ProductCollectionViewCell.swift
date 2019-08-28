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
    
    var productId: String = ""
    
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
    
    // MARK: - Actions
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
    }
}

private extension ProductCollectionViewCell {
    
    func setupShadows() {
        
        layer.cornerRadius = 16
        layer.masksToBounds = false
        
        
//        let shadowRect = CGRect(x: 0, y: 6, width: bounds.width, height: bounds.height)
//        containerView.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
//        containerView.layer.shadowColor = UIColor.black.cgColor
//        containerView.layer.shadowRadius = 6
//        containerView.layer.shadowOpacity = 0.12
        
        containerView.layer.applySketchShadow(y: -2)
        containerView.layer.applySketchShadow(y: 8)
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.1,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 8,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
