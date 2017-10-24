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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectionIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
        
        self.invites = []
        if let userInvites = user.invites {
            for (_, value) in userInvites {
                self.invites.append(value)
            }
            tableView.reloadData()
        }
        
        self.navigationItem.title = "Invites"
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "invitationResponseSegue", sender: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "invitationResponseSegue":
            let responseView = segue.destination as! InvitationResponseViewController
            if let selectedPath = tableView.indexPathForSelectedRow {
                responseView.invitation = invites[selectedPath.row]
            }
            responseView.user = self.user
        default:
            fatalError("Unexpected segue identifier")
        }
    }
}
