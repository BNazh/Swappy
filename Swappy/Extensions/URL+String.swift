//
//  URL+String.swift
//  Swappy
//
//  Created by Mihail on 13/08/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Foundation

extension String {
    
    var asUrl: URL? {
        return URL(string: self)
    }
}
