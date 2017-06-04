//
//  MeetingHistory.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class MeetingHistory {
    var history = [MeetingNotes]()
    
    init() {
        
    }
    
    internal init(history: [MeetingNotes]) {
        self.history = history
    }
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        
        let meetingNotesJSON = self.history.map({member in
            return member.jsonObject})
        output[MeetingHistory.historyLabel] = meetingNotesJSON
        
        return output
    }
    
    convenience init(jsonDictionary: [String:Any]) {
        if let history = jsonDictionary[MeetingHistory.historyLabel] as? [[String:Any]] {
            let meetingNotes = history.map({member in
                return MeetingNotes(jsonDictionary: member)!})
            self.init(history: meetingNotes)
        } else {
            self.init()
        }
    }
    
    public static let historyLabel = "History"
}
