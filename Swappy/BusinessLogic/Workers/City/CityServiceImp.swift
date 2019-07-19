//
//  CityServiceImp.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

final class CityServiceImp {
    
    // MARK: - Properties
    
    private let settingsStore: KeychainStore
    
    // MARK: - Init
    
    init(settingsStore: KeychainStore) {
        self.settingsStore = settingsStore
    }
}

// MARK: - CityService

extension CityServiceImp: CityService {
    
    // MARK: - Properties
    
    var selectedCity: City? {
        get {
            return settingsStore.welcomeCity
        }
        set {
            settingsStore.welcomeCity = newValue
        }
    }
    
    var cities: [City] {
        return [
            City(title: "Москва"),
            City(title: "Питер")
        ]
    }
    
    // MARK: - Functions
    
    func updateCitiesList(_ closure: (Result<[City]>) -> Void) {
        closure(.success(cities))
    }
}

