//
//  Result.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

typealias ResultCallback<T> = (Result<T>) -> Void

enum Result<T> {
    case
    success(T),
    failure(AppError)
}

extension Result {
    
    var value: T? {
        switch self {
        case .success(let result):
            return result
        case .failure:
            return nil
        }
    }
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    var isFailure: Bool {
        return !isSuccess
    }
}
