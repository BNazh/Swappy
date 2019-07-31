//
//  HeaderViewModel.swift
//  Swappy
//
//  Created by Mihail on 24/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

struct HeaderViewModel {
    
    let title: String
    let image: UIImage?
    
    init(title: String, image: UIImage? = nil) {
        self.title = title
        self.image = image
    }
}
