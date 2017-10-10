//
//  Invite.swift
//  InOrder
//
//  Created by Brent Fordham on 10/10/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class Invite {
    let inviteID: UUID
    let groupID: UUID
    let groupName: String
    
    init (inviteID: UUID, groupID: UUID, groupName: String) {
        self.groupID = groupID
        self.groupName = groupName
        self.inviteID = inviteID
    }
}
