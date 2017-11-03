//
//  InvitationResponseViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/21/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class InvitationResponseViewController: UIViewController {
    @IBOutlet var InvitationView: UITextView!
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var declineButton: UIButton!
    @IBOutlet var answerLaterButton: UIButton!
    
    let usersRef = Database.database().reference(withPath: "Users")
    var currentUserRef: DatabaseReference!
    let groupsRef = Database.database().reference(withPath: "Groups")
    var currentGroupRef: DatabaseReference!
    
    var user: InOrderUser!
    var invitation: Invite!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentUserRef = usersRef.child(user.id)
        self.currentGroupRef = groupsRef.child(invitation.groupID.uuidString)
        
        self.InvitationView.text = "You've been invited to join the group \(invitation.groupName)."
        
        acceptButton.layer.cornerRadius = 7
        acceptButton.layer.borderWidth = 1
        acceptButton.layer.borderColor = UIColor.lightGray.cgColor
        
        declineButton.layer.cornerRadius = 7
        declineButton.layer.borderWidth = 1
        declineButton.layer.borderColor = UIColor.lightGray.cgColor
        
        answerLaterButton.layer.cornerRadius = 7
        answerLaterButton.layer.borderWidth = 1
        answerLaterButton.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    func pathSafeEmail(_ input: String) -> String {
        let pathSafeArray = input.characters.map({character -> Character in
            switch character {
            case ".":
                return ","
            default:
                return character
            }
        })
        
        let pathSafeString = String(pathSafeArray)
        
        return pathSafeString
    }
    
    func acceptInvitation() {
        let acceptedGroupReference = GroupDirectoryEntry(name: self.invitation.groupName, id: self.invitation.groupID)
        user.readOnlyGroupDirectory.append(acceptedGroupReference)
        let groupMembersRef = currentGroupRef.child("Members")
        let userEmailForPath = pathSafeEmail(user.email)
        let newMemberRef = groupMembersRef.child(userEmailForPath)
        newMemberRef.setValue(user.memberOnlyJSONObject)
        if user.invites != nil {
            user.invites![invitation.inviteID] = nil
        }
        currentUserRef.setValue(user.jsonObject)
    }
    
    func declineInvitation() {
        if user.invites != nil {
            user.invites![invitation.inviteID] = nil
        }
        currentUserRef.setValue(user.jsonObject)
    }
    
    @IBAction func accept(_ sender: UIButton) {
        acceptInvitation()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func decline(_ sender: UIButton) {
        declineInvitation()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func answerLater(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
