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
    authenticate(phone: String, code: String),
    vkAuth(accessToken: String, email: String)
}

extension AuthTarget: TargetType {
    var baseURL: URL {
        return Core.authBaseUrl
    }
    
    var path: String {
        switch self {
        case .requestSmsVerification:
            return "phone/requestSMSVerificationCode"
        case .authenticate:
            return "phone/authenticate"
        case .vkAuth:
            return "oauth2/vk"
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
            
        case .vkAuth(let accessToken, let email):
            return [
                "accessToken": accessToken,
                "email": email
            ]
        }
    }
}
