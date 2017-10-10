//
//  InvitesViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/10/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class InvitesViewController: UITableViewController {
    var invites: [Invite]!
    var user: User!
    
    override func loadView() {
        super.loadView()
        
        self.invites = []
        let fakeInvite = Invite(inviteID: UUID(), groupID: UUID(), groupName: "Not a real group")
        invites.append(fakeInvite)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inviteCell", for: indexPath)
        let invite = invites[indexPath.row]
        cell.textLabel?.text = invite.groupName
        
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let fakeReference = GroupDirectoryEntry(name: invites[0].groupName, id: invites[0].groupID)
        user.readOnlyGroupDirectory.append(fakeReference)
    }
}
