//
//  AppError.swift
//  Swappy
//
//  Created by Бабаев Михаил Михайлович on 07/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

enum AppError {
    case
    server(message: String),
    unknown,
    base(Error),
    decoding
}

extension AppError {
    
    var localizedString: String {
        switch self {
        case .server(let message):
            return message
        default:
            return "Произошла неизвестная ошибка"
        }
    }
}

extension Error {
    
    var moya: MoyaError {
        guard let moyaError = self as? MoyaError else {
            return MoyaError.encodableMapping(self)
        }
        
        return moyaError
    }
}
