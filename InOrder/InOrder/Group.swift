//
//  Group.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class Group {
    var name: String
    var description: String
    var moderator: User
    var members: [String]
    var meetingHistory: MeetingHistory
    
    init(name: String, description: String, moderator: User, members: [String], meetingHistory: MeetingHistory) {
        self.name = name
        self.description = description
        self.moderator = moderator
        self.members = members
        self.meetingHistory = meetingHistory
    }
    
    public static let nameLabel = "Name"
    public static let descriptionLabel = "Description"
    public static let moderatorLabel = "Moderator"
    public static let membersLabel = "Members"
    public static let meetingHistoryLabel = "Meetinghistory"
}
