//
//  ProfileHeader.swift
//  Swappy
//
//  Created by Mihail on 04/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    
    func headerViewDidPressButton(_ headerView: HeaderView)
}

final class HeaderView: UICollectionReusableView {
    
    // MARK: - Properties

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - Actions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.headerViewDidPressButton(self)
    }
    
    // MARK: - Functions
    
    func configure(with viewModel: HeaderViewModel, delegate: HeaderViewDelegate? = nil) {
        titleLabel.text = viewModel.title
        
        button.sd_setImage(with: viewModel.avatarURL, for: .normal, completed: nil)
        button.isHidden = viewModel.hideImage
        
        self.delegate = delegate
    }
}
