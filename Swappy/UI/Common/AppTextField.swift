//
//  AppTextField.swift
//  Swappy
//
//  Created by Mihail on 18/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import SkyFloatingLabelTextField

final class AppTextField: SkyFloatingLabelTextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // No formatting
        titleFormatter = { return $0 }
    
        // Fonts
        placeholderFont = .appFont(ofSize: 16)
        titleFont = .appFont(ofSize: 13)
        font = .appFont(ofSize: 16)
        
        // Colors
        placeholderColor = UIColor(r: 140, g: 140, b: 140)
        selectedTitleColor = UIColor(r: 121, g: 121, b: 121)
        textColor = UIColor(r: 51, g: 51, b: 51)
        tintColor = .black
    }
}
