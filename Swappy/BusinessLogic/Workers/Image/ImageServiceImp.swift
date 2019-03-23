//
//  ImageServiceImp.swift
//  Swappy
//
//  Created by Mihail on 23/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import UIKit
import Moya

final class ImageServiceImp {

    let provider: MoyaProvider<ImageTarget>
    
    init(provider: MoyaProvider<ImageTarget>) {
        self.provider = provider
    }
}

extension ImageServiceImp: ImageService {
    
    func uploadImage(_ image: UIImage, callback: @escaping ResultCallback<String>) {
        guard let data = image.pngData() else {
            callback(.failure(.unknown))
            return
        }
        
        let request = ImageTarget.uploadImage(data)
        provider.requestDecodable(request, callback: callback)
    }
}
