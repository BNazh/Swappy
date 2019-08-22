//
//  Resolver+Extension.swift
//  Swappy
//
//  Created by Mihail on 04/04/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

import Swinject

extension Resolver {
    
    func resolve<Service>() -> Service {
        return resolve(Service.self)!
    }
    
    func resolve<Service, Arg>(argument: Arg) -> Service {
        return resolve(Service.self, argument: argument)!
    }
    
    func resolve<Service, Arg1, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        return resolve(Service.self, arguments: arg1, arg2)!
    }
}
