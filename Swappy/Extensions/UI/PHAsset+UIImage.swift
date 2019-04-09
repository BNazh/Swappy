//
//  UIImage.swift
//  Swappy
//
//  Created by Mihail on 24/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import Photos

extension PHAsset {
    
    var image: UIImage? {
        var img: UIImage?
        
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        
        //let size = PHImageManagerMaximumSize
        let size = CGSize(width: 300, height: 300)
        manager.requestImage(for: self, targetSize: size, contentMode: .aspectFit, options: options) { (image, _) in
            img = image
        }
        
        return img
    }
}
