//
//  VKButton.swift
//  Swappy
//
//  Created by Mihail on 17/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

final class VKButton: BaseButton {
    
    override func commonInit() {
        super.commonInit()
        
        self.backgroundColor = .vkBackground
        self.setTitleColor(.white, for: .normal)
    }
}
