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
        return Core.baseUrl.appendingPathComponent("swappy-auth/phone/")
    }
    
    var path: String {
        switch self {
        case .requestSmsVerification:
            return "requestSMSVerificationCode"
        case .authenticate:
            return "authenticate"
        }
    }
    
    var method: Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestCompositeParameters(
            bodyParameters: parameters,
            bodyEncoding: JSONEncoding.default,
            urlParameters: [:]
        )
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
                "phoneNumber" : phone
            ]
            
        case .authenticate(let phone, let code):
            return [
                "phoneNumber": phone,
                "verificationCode": code
            ]
        }
    }
}
