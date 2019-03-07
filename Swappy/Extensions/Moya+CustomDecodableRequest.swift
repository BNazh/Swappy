//
//  Moya+CustomDecodableRequest.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

extension MoyaProvider {
    
    @discardableResult
    func requestDecodable<T: Decodable>(_ target: Target,
                                        callback: @escaping ResultCallback<T>) -> Cancellable {
        
        return request(target) { response in
            
            switch response {
                
            case .success(let moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let decodedResponse = try filteredResponse.map(DataResponse<T>.self)
                    
                    callback(.success(decodedResponse.data))
                }
                catch {
                    callback(.failure(.decoding))
                }
            case .failure(let error):
                callback(.failure(.server(message: error.errorDescription ?? "")))
            }
        }
    }
}
