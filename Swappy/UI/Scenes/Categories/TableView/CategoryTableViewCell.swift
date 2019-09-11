//
//  CategoryTableViewCell.swift
//  Swappy
//
//  Created by Mihail on 31/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    // MARK: - Function:
    
    func configure(with viewModel: CategoryCellViewModel) {
        categoryTitleLabel.text = viewModel.title
        categoryImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
