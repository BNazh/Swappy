//
//  Data+String.swift
//  Swappy
//
//  Created by Mihail on 12/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation
import Moya

extension Data {
    
    var stringValue: String {
        return String(data: self, encoding: .utf8) ?? "nil"
    }
}

extension Response {
    
    var httpBodyString: String {
        return request?.httpBody?.stringValue ?? "nil"
    }
    
    var responseString: String {
        return data.stringValue
    }
}
