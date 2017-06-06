//
//  Group.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class Group {
    var name: String = "Add your group name here."
    var description: String = "Add a description of your group."
    var meetingHistory: MeetingHistory = MeetingHistory()
    var upcomingAgenda: Agenda = Agenda()
    
    init() {
        
    }
    
    internal init(name: String?, description: String?, meetingHistory: MeetingHistory?, upcomingAgenda: Agenda?) {
        if let initName = name {
            self.name = initName
        }
        if let initDescription = description {
            self.description = initDescription
        }
        if let initMeetingHistory = meetingHistory {
            self.meetingHistory = initMeetingHistory
        }
        if let initUpcomingAgenda = upcomingAgenda {
            self.upcomingAgenda = initUpcomingAgenda
        }
    }
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        output[Group.nameLabel] = name
        output[Group.descriptionLabel] = description
        output[Group.meetingHistoryLabel] = meetingHistory.jsonObject
        output[Group.upcomingAgendaLabel] = upcomingAgenda.jsonObject
        return output
    }
    
    convenience init(jsonDictionary: [String:Any]) {
        var name: String? {
            if let jsonName = jsonDictionary[Group.nameLabel] as? String {
                return jsonName
            } else {
                return nil
            }
        }
        var description: String? {
            if let jsonDescription = jsonDictionary[Group.descriptionLabel] as? String {
                return jsonDescription
            } else {
                return nil
            }
        }
        var meetingHistory: MeetingHistory? {
            if let jsonMeetingHistory = jsonDictionary[Group.meetingHistoryLabel] as? [String:Any] {
                return MeetingHistory(jsonDictionary: jsonMeetingHistory)
            } else {
                return nil
            }
        }
        var upcomingAgenda: Agenda? {
            if let jsonUpcomingAgenda = jsonDictionary[Group.upcomingAgendaLabel] as? [String:Any] {
                return Agenda(jsonDictionary: jsonUpcomingAgenda)
            } else {
                return nil
            }
        }
        self.init(name: name, description: description, meetingHistory: meetingHistory, upcomingAgenda: upcomingAgenda)
    }
    
    func save() {
        
    }
    
    public static let nameLabel = "Name"
    public static let descriptionLabel = "Description"
    public static let moderatorLabel = "Moderator"
    public static let meetingHistoryLabel = "Meetinghistory"
    public static let upcomingAgendaLabel = "Upcomingagenda"
}
