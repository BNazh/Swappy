//
//  FBButton.swift
//  Swappy
//
//  Created by Mihail on 12/05/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

final class FBButton: BaseButton {
    
    override func commonInit() {
        super.commonInit()
        
        self.backgroundColor = .fbBackground
        self.setTitleColor(.white, for: .normal)
    }
}
