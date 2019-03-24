//
//  ImageService.swift
//  Swappy
//
//  Created by Mihail on 23/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol ImageService: class {
    
    func cancelCurrentOperation()
    
    func uploadImage(_ image: UIImage,
                     progressBlock: @escaping (Double) -> Void,
                     callback: @escaping ResultCallback<String>)
}
