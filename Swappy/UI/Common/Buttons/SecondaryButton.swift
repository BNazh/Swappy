//
//  SecondaryButton.swift
//  Swappy
//
//  Created by Mihail on 13/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class SecondaryButton: BaseButton {
    
    // MARK: - Constants
    
    private enum Constants {
        static let background = UIColor.whiteSmoke
        static let textColor = UIColor.black
    }
    
    // MARK: - Functions
    
    override func commonInit() {
        super.commonInit()
        
        setTitleColor(Constants.textColor, for: .normal)
        backgroundColor = Constants.background
    }
}
