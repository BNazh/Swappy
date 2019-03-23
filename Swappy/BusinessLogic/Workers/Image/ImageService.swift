//
//  ImageService.swift
//  Swappy
//
//  Created by Mihail on 23/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ImageService: class {
    
    func uploadImage(_ image: UIImage, callback: @escaping ResultCallback<String>)
}
