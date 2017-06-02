//
//  AgendaItem.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class AgendaItem {
    enum ItemStatus {
        case passed
        case failed
        case tabled
    }
    
    var name: String
    var description: String
    
    var notes: [Note]?
    var amendments: [Note]?
    
    var votesFor: Int?
    var votesAgainst: Int?
    var abstensions: Int?
    
    var status: ItemStatus?

    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
