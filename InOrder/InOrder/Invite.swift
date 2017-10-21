//
//  Invite.swift
//  InOrder
//
//  Created by Brent Fordham on 10/10/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import Firebase

class Invite {
    let inviteID: UUID
    let groupID: UUID
    let groupName: String
    
    init (inviteID: UUID, groupID: UUID, groupName: String) {
        self.groupID = groupID
        self.groupName = groupName
        self.inviteID = inviteID
    }
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        output[Invite.inviteIDLabel] = inviteID.uuidString
        output[Invite.groupIDLabel] = groupID.uuidString
        output[Invite.nameLabel] = groupName
        return output
    }
    
    convenience init? (snapshot: DataSnapshot) {
        guard let jsonDictionary = snapshot.value as? [String:Any],
        let inviteIDString = jsonDictionary[Invite.inviteIDLabel] as? String,
        let inviteID = UUID(uuidString: inviteIDString),
        let groupIDString = jsonDictionary[Invite.groupIDLabel] as? String,
        let groupID = UUID(uuidString: groupIDString),
            let groupName = jsonDictionary[Invite.nameLabel] as? String else {
                return nil
        }
        
        self.init(inviteID: inviteID, groupID: groupID, groupName: groupName)
    }
    
    public static let groupIDLabel = "GroupID"
    public static let nameLabel = "Name"
    public static let inviteIDLabel = "InviteID"
}
