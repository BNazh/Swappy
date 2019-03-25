//
//  DeleteButton.swift
//  Swappy
//
//  Created by Mihail on 25/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

final class DeleteButton: BaseButton {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let background = UIColor.munsell
        static let textColor = UIColor.coralRed
        static let highlightedTextColor = UIColor.coralRed.withAlphaComponent(0.6)
    }
    
    // MARK: - Functions
    
    override func commonInit() {
        super.commonInit()
        
        setTitleColor(Constants.textColor, for: .normal)
        setTitleColor(Constants.highlightedTextColor, for: .highlighted)
        backgroundColor = Constants.background
    }
}
