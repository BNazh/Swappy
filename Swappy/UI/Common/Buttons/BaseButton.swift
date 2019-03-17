//
//  BaseButton.swift
//  Swappy
//
//  Created by Mihail on 14/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let titleLabelFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    // MARK: - Functions
    
    func commonInit() {
        layer.cornerRadius = Constants.cornerRadius
        titleLabel?.font = Constants.titleLabelFont
    }
}
