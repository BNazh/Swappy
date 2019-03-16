//
//  MainButton.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 10/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

class MainButton: BaseButton {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let background = UIColor.black
        static let textColor = UIColor.white
    }
    
    // MARK: - Functions
    
    override func commonInit() {
        super.commonInit()
        
        setTitleColor(Constants.textColor, for: .normal)
        backgroundColor = Constants.background
    }
}
