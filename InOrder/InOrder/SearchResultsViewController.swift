//
//  SearchResultsViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/21/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SearchResultsViewController: UIViewController {
    let allUsersRef = Database.database().reference(withPath: "Users")
    var userToInviteRef: DatabaseReference!
    var userToInvite: Member!
    var groupName: String!
    var groupID: UUID!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var sendInviteButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userToInviteRef = allUsersRef.child(userToInvite.id)
        
        nameField.text = userToInvite.name
        emailField.text = userToInvite.email
    }
    
    func createInvitation() {
        let invitation = Invite(inviteID: UUID(), groupID: self.groupID, groupName: self.groupName)
        let invitationData = invitation.jsonObject
        
        let userInvitesRef = userToInviteRef.child("Invites")
        let sentInviteRef = userInvitesRef.child(invitation.inviteID.uuidString)
        sentInviteRef.setValue(invitationData)
    }
    
    @IBAction func sendInvite(_ sender: UIButton) {
        createInvitation()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
