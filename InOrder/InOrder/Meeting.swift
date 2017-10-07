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
    
}
