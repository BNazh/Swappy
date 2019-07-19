//
//  CategoryTableViewCell.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

struct SelectionItemViewModel {
    let id: String
    let name: String
    let icon: UIImage
    let isSelected: Bool
}

final class SelectionItemTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    // MARK: - Functions
    
    func setup(with viewModel: SelectionItemViewModel) {
        nameLabel.text = viewModel.name
        iconImageView.image = viewModel.icon
        
        setSelected(viewModel.isSelected, animated: false)
    }
}
