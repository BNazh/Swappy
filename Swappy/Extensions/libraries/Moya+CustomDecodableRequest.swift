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
        
        return request(target) { result in
            
            switch result {
                
            case .success(let moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let decodedResponse = try filteredResponse.map(DataResponse<T>.self)
                    
                    callback(.success(decodedResponse.data))
                }
                catch {
                    let appError = self.appError(from: error.moya)
                    callback(.failure(appError))
                }
                
            case .failure(let moyaError):
                let appError = self.appError(from: moyaError)
                callback(.failure(appError))
            }
        }
    }
}

private extension MoyaProvider {
    
    func appError(from moyaError: MoyaError) -> AppError {
        
        switch moyaError {
            
        case .statusCode(let response):
            let message = try? response.mapString(atKeyPath: "message")
            
            return .server(statusCode: response.statusCode,
                           message: message ?? "")
            
        case .objectMapping:
            return .decoding
            
        case .underlying(let error, _) where (error as NSError).code == NSURLErrorCancelled:
            return .cancelled
            
        default:
            return .unknown
        }
    }
}
