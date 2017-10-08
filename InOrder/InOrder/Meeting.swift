//
//  Meeting.swift
//  InOrder
//
//  Created by Brent Fordham on 9/20/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class Meeting {
    
    enum MeetingStatus: String {
        case upcoming = "Upcoming"
        case inProgress = "In-Progress"
        case recessed = "Recessed"
        case adjourned = "Adjourned"
    }
    
    var title: String
    var agenda: Agenda
    var status: MeetingStatus
    
    init (title: String, agenda: Agenda, status: MeetingStatus) {
        self.title = title
        self.agenda = agenda
        self.status = status
    }
    
    var JSONDictionary: [String:Any] {
        var output = [String:Any]()
        output[Meeting.titleLabel] = title
        output[Meeting.agendaLabel] = agenda.jsonObject
        output[Meeting.statusLabel] = status.rawValue
        return output
    }
    
    public static let titleLabel = "Title"
    public static let agendaLabel = "Agenda"
    public static let statusLabel = "Status"
}
