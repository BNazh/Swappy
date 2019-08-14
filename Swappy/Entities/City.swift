//
//  City.swift
//  Swappy
//
//  Created by Mihail on 14/07/2019.
//  Copyright © 2019 SwappyTeam. All rights reserved.
//

struct City: Codable {
    
    let title: String
    
    init?(title: String?) {
        guard let title = title else {
            return nil
        }
        self.title = title
    }
}

// MARK: - SelectionItem

extension City: SelectionItem {
    
    var selectionId: String {
        return title
    }
    
    var selectionTitle: String {
        return title
    }
}
