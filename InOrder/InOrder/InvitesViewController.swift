//
//  InvitesViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/10/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class InvitesViewController: UITableViewController {
    
    let usersRef = Database.database().reference(withPath: "Users")
    var currentUserRef: DatabaseReference!
    var currentUserInvitesRef: DatabaseReference!
    var invitesObserver: UInt!
    var invites: [Invite]!
    var user: InOrderUser!
    
    override func loadView() {
        super.loadView()
        
        self.currentUserRef = usersRef.child(user.id)
        self.currentUserInvitesRef = currentUserRef.child("Invites")
        
        self.invites = []
        
        self.invitesObserver = currentUserInvitesRef.observe(.value, with: {snapshot in
            if snapshot.exists() {
                for invite in snapshot.children {
                    if let invitation = Invite(snapshot: invite as! DataSnapshot) {
                        self.invites.append(invitation)
                        self.tableView.reloadData()
                    }
                }
            }
        })
        
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
        
    }
}
