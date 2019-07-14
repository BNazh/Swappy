//
//  CityServiceImp.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

final class CityServiceImp {
    
    var selectedCity: City?
}

// MARK: - CityService

extension CityServiceImp: CityService {
    
    var cities: [City] {
        return [
            City(title: "Москва"),
            City(title: "Питер")
        ]
    }
    
    func updateCitiesList(_ closure: (Result<[City]>) -> Void) {
        closure(.success(cities))
    }
}

