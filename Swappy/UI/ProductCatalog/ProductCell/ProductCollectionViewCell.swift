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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityLabel.layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        print("Cancel \(imageView.sd_imageURL()?.absoluteString)")
        print(titleLabel.text)
        
        imageView.image = nil
    }
    
    func configure(with viewModel: ProductCellViewModel) {
        titleLabel.attributedText = viewModel.title
        priceLabel.text = viewModel.price
        cityLabel.text = viewModel.city
        
        imageView.sd_setImage(with: viewModel.imageURL)
    }
} 
