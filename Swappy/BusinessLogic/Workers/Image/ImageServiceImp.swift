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
    
//    var progressBlock: ((Double) -> Void)?
//    var completionBlock: ((String?) -> Void)?

    private let provider: MoyaProvider<ImageTarget>
    private var currentOperation: Cancellable?
    
    init(provider: MoyaProvider<ImageTarget>) {
        self.provider = provider
    }
}

extension ImageServiceImp: ImageService {
    
    
    func uploadImage(_ image: UIImage, progressBlock: @escaping (Double) -> Void, callback: @escaping ResultCallback<String>) {
        guard let data = image.pngData() else {
            callback(.failure(.unknown))
            return
        }
        
        let request = ImageTarget.uploadImage(data)
        
        currentOperation = provider.request(
            request,
            progress: { progressResponse in
                progressBlock(progressResponse.progress)
            }, completion: { result in
                switch result {
                case .success(let value):
                    if let url = try? value.mapString(atKeyPath: "data") {
                        callback(.success(url))
                    } else {
                        callback(.failure(.unknown))
                    }
                case .failure:
                    callback(.failure(.unknown))
                }
            }
        )
    }
    
    func cancelCurrentOperation() {
        currentOperation?.cancel()
    }
}
