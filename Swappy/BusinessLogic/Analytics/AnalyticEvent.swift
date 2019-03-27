//
//  AnalyticEvent.swift
//  Swappy
//
//  Created by Mihail on 28/03/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

enum AnalyticEvent: String {
    case
    openSeller,
    loadProducts
}

protocol AnalyticScreen {
    
    var screenName: String { get }
}

