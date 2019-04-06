//
//  ImageTarget.swift
//  Swappy
//
//  Created by Mihail on 23/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

enum ImageTarget {
    case
    uploadImage(Data)
}

extension ImageTarget: TargetType {
    
    var baseURL: URL {
        return Core.baseUrl
        //return Core.testUrl
    }
    
    var path: String {
        return "images/"
    }
    
    var method: Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .uploadImage(let data):
            let formData = MultipartFormData(provider: .data(data), name: "file", fileName: "file.png", mimeType: "image/png")
            let multipartData = [formData]
            
            return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}


