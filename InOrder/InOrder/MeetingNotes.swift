//
//  MeetingNotes.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class MeetingNotes {
    let date: Date
    var generalNotes = [Note]()
    var itemsPassed = [AgendaItem]()
    var itemsFailed = [AgendaItem]()
    var itemsTabled = [AgendaItem]()
    
    init(date: Date) {
        self.date = MeetingNotes.sanitize(date: date)
    }
    
    internal init(date: Date, generalNotes: [Note]?, itemsPassed: [AgendaItem]?, itemsFailed: [AgendaItem]?, itemsTabled: [AgendaItem]?) {
        self.date = MeetingNotes.sanitize(date: date)
        
        if let initGeneralNotes = generalNotes {
            self.generalNotes = initGeneralNotes
        }
        if let initItemsPassed = itemsPassed {
            self.itemsPassed = initItemsPassed
        }
        if let iniItemsFailed = itemsFailed {
            self.itemsFailed = iniItemsFailed
        }
        if let initItemsTabled = itemsTabled {
            self.itemsTabled = initItemsTabled
        }
    }
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        
        if generalNotes.isEmpty == false {
            output[MeetingNotes.generalNotesLabel] = self.generalNotes.map({element in
                return element.jsonObject})
        }
        if itemsPassed.isEmpty == false {
            output[MeetingNotes.itemsPasedLabel] = self.itemsPassed.map({element in
                return element.jsonObject})
        }
        if itemsFailed.isEmpty == false {
            output[MeetingNotes.itemsFailedLabel] = self.itemsFailed.map({element in
                return element.jsonObject})
        }
        if itemsTabled.isEmpty == false {
            output[MeetingNotes.itemsTabledLabel] = self.itemsTabled.map({element in
                return element.jsonObject})
        }
        
        output[MeetingNotes.dateLabel] = self.date.timeIntervalSince1970
        
        return output
    }
    
    convenience init?(jsonDictionary: [String:Any]) {
        guard let dateAsDouble = jsonDictionary[MeetingNotes.dateLabel] as? Double
            else {
                return nil
        }
        
        let date = Date(timeIntervalSince1970: dateAsDouble)
        
        var generalNotes: [Note]? {
            if let generalNotesJSON = jsonDictionary[MeetingNotes.generalNotesLabel] as? [[String:Any]] {
                return generalNotesJSON.map({element in
                    return Note(jsonDictionary: element)!})
            } else {
                return nil
            }
        }
        
        var itemsPassed: [AgendaItem]? {
            if let itemsPassedJSON = jsonDictionary[MeetingNotes.itemsPasedLabel] as? [[String:Any]] {
                return itemsPassedJSON.map({element in
                    return AgendaItem(jsonDictionary: element)!})
            } else {
                return nil
            }
        }
        
        var itemsFailed: [AgendaItem]? {
            if let itemsFailedJSON = jsonDictionary[MeetingNotes.itemsFailedLabel] as? [[String:Any]] {
                return itemsFailedJSON.map({element in
                    return AgendaItem(jsonDictionary: element)!})
            } else {
                return nil
            }
        }
        
        var itemsTabled: [AgendaItem]? {
            if let itemsTabledJSON = jsonDictionary[MeetingNotes.itemsTabledLabel] as? [[String:Any]] {
                return itemsTabledJSON.map({element in
                    return AgendaItem(jsonDictionary: element)!})
            } else {
                return nil
            }
        }
        
        self.init(date: date, generalNotes: generalNotes, itemsPassed: itemsPassed, itemsFailed: itemsFailed, itemsTabled: itemsTabled)
    }
    
    public static let dateLabel = "Date"
    public static let generalNotesLabel = "Generalnotes"
    public static let itemsPasedLabel = "Itemspassed"
    public static let itemsFailedLabel = "Itemsfailed"
    public static let itemsTabledLabel = "Itemstabled"
}

extension MeetingNotes {
    static func sanitize(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        return calendar.date(from: components)!
    }
}
