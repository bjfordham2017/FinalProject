//
//  MeetingNotes.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class MeetingNotes {
    let date: Date //this will need more formatting
    var generalNotes: [Note]
    var itemsPassed: [AgendaItem]
    var itemsFailed: [AgendaItem]
    var itemsTabled: [AgendaItem]
    
    init(date: Date, generalNotes: [Note], itemsPassed: [AgendaItem], itemsFailed: [AgendaItem], itemsTabled: [AgendaItem]) {
        self.date = date
        self.generalNotes = generalNotes
        self.itemsPassed = itemsPassed
        self.itemsFailed = itemsFailed
        self.itemsTabled = itemsTabled
    }
    
    public static let dateLabel = "Date"
    public static let generalNotesLabel = "Generalnotes"
    public static let itemsPasedLabel = "Itemspassed"
    public static let itemsFailedLabel = "Itemsfailed"
    public static let itemsTabledLabel = "Itemstabled"
}
