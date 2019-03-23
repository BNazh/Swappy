//
//  PhotosPresenter.swift
//  Swappy
//
//  Created by Mihail on 23/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit

protocol PhotosPresenter: class {
    
    func uploadPhoto(_ image: UIImage, at index: Int)
    
    
}

final class PhotosPresenterImp {
    
    let service: ImageService
    
    init(service: ImageService) {
        self.service = service
    }
}

extension PhotosPresenterImp: PhotosPresenter {
    
    func uploadPhoto(_ image: UIImage, at index: Int) {
        service.uploadImage(image) { result in
            print(result.value)
            print(result.error)
        }
    }
}
