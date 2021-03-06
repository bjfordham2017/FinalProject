//
//  Group.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import Firebase

class Group {
    let groupID: UUID
    var name: String = "Add your group name here."
    var description: String = "Add a description of your group."
    var meetingHistory: MeetingHistory = MeetingHistory()
    var upcomingAgenda: Agenda = Agenda()
    var members: [String:Member]?
    
    init() {
        self.groupID = UUID()
    }
    
    internal init(groupID: UUID?, name: String?, description: String?, meetingHistory: MeetingHistory?, upcomingAgenda: Agenda?, members: [String:Member]? = nil) {
        if let initGoupID = groupID {
            self.groupID = initGoupID
        } else {
            self.groupID = UUID()
        }
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
        
        if let initMembers = members {
            self.members = initMembers
        }
    }
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        output[Group.groupIDLabel] = groupID.uuidString
        output[Group.nameLabel] = name
        output[Group.descriptionLabel] = description
        output[Group.meetingHistoryLabel] = meetingHistory.jsonObject
        output[Group.upcomingAgendaLabel] = upcomingAgenda.jsonObject
        if let membership = members {
            var membersJSON = [String:[String:Any]]()
            for (key, value) in membership {
                membersJSON[key] = value.jsonObject
            }
            output[Group.memberslabel] = membersJSON
        }

        return output
    }
    
    convenience init(jsonDictionary: [String:Any]) {
        var groupID: UUID? {
            if let jsonID = jsonDictionary[Group.groupIDLabel] as? String,
                let uid = UUID(uuidString: jsonID) {
                return uid
            } else {
                return nil
            }
        }
        
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
        self.init(groupID: groupID, name: name, description: description, meetingHistory: meetingHistory, upcomingAgenda: upcomingAgenda)
    }
    
    convenience init? (dataSnapshot: DataSnapshot) {
        guard let jsonDictionary = dataSnapshot.value as? [String:Any] else {
            return nil
        }
        
        var groupID: UUID? {
            if let jsonID = jsonDictionary[Group.groupIDLabel] as? String,
                let uid = UUID(uuidString: jsonID) {
                return uid
            } else {
                return nil
            }
        }
        
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
        
        var members: [String:Member]? {
            guard let invitesJSON = jsonDictionary[Group.memberslabel] as? [String:Any] else {
                return nil
            }
            var membersDictionaryOfJSONObjects = [String:[String:Any]]()
            for (key, value) in invitesJSON {
                membersDictionaryOfJSONObjects[key] = value as? [String:Any]
            }
            var membersInitialized = [String:Member]()
            for (key, value) in membersDictionaryOfJSONObjects {
                membersInitialized[key] = Member(jsonObject: value)
            }
            
            return membersInitialized
        }
        
        self.init(groupID: groupID, name: name, description: description, meetingHistory: meetingHistory, upcomingAgenda: upcomingAgenda, members: members)
    }
    
    convenience init (fromID id: UUID) {
        let filePath: URL = {
            let documentsDirectories =
                FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentDirectory = documentsDirectories.first!
            return documentDirectory.appendingPathComponent("\(id.uuidString).json")
        }()
        
        if let data = try? Data(contentsOf: filePath),
            let JSON = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonDictionary = JSON as? [String:Any] {
                self.init(jsonDictionary: jsonDictionary)
        } else {
            self.init()
        }

    }
    
    func save() {
        let filePath: URL = {
            let documentsDirectories =
                FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentDirectory = documentsDirectories.first!
            return documentDirectory.appendingPathComponent("\(self.groupID.uuidString).json")
        }()
        
        do {
            let data = try JSONSerialization.data(withJSONObject: self.jsonObject, options: [])
            try data.write(to: filePath)
        } catch {
            print(error)
        }

    }
    
    public static let groupIDLabel = "GroupID"
    public static let nameLabel = "Name"
    public static let descriptionLabel = "Description"
    public static let moderatorLabel = "Moderator"
    public static let meetingHistoryLabel = "Meetinghistory"
    public static let upcomingAgendaLabel = "Upcomingagenda"
    public static let memberslabel = "Members"
}
