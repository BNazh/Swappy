//
//  UserTarget.swift
//  Swappy
//
//  Created by Mihail on 29/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Moya

enum UserTarget {
    case
    updateUser(id: String, user: UserRO)
}

extension UserTarget: TargetType {
    
    var baseURL: URL {
        return Core.userBaseUrl
    }
    
    var path: String {
        switch self {
        case .updateUser(let id, _):
            return "users/\(id)"
        }
    }
    
    var method: Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .updateUser(_, let user):
            return .requestJSONEncodable(user)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

extension UserTarget {
    
    struct UserRO: Encodable {
        
        // MARK: - Properties
        
        let firstName: String
        let lastName: String?
        let avatarUrl: String?
    }
}


