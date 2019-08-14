//
//  HeaderViewModel.swift
//  Swappy
//
//  Created by Mihail on 24/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

struct HeaderViewModel {
    
    // MARK: - Properties
    
    let title: String
    let avatarURL: URL?
    let hideImage: Bool
    
    // MARK: - Inits
    
    init(title: String) {
        self.title = title
        avatarURL = nil
        hideImage = true
    }
    
    init(title: String, avatarURL: URL?) {
        self.title = title
        self.avatarURL = avatarURL
        hideImage = false
    }
}
