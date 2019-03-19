//
//  AuthTarget.swift
//  Swappy
//
//  Created by Mihail on 19/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

enum AuthTarget {
    case
    requestSmsVerification(phone: String),
    authenticate(phone: String, code: String)
}

extension AuthTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://swappy.ru/swappy-auth/")!
    }
    
    var path: String {
        switch self {
        case .requestSmsVerification:
            return "phone/requestSMSVerificationCode"
        case .authenticate:
            return "phone/authenticate"
        }
    }
    
    var method: Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters,
                                  encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return nil
    }
}

private extension AuthTarget {
    
    var parameters: [String : Any] {
        switch self {
            
        case .requestSmsVerification(let phone):
            return [
                "phone" : phone
            ]
            
        case .authenticate(let phone, let code):
            return [
                "phone": phone,
                "code": code
            ]
        }
    }
}
