//
//  ViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate, MeetingDelegate, GroupDetailDelegate {

    var group: Group!
    var user: InOrderUser!
    var groupRef: GroupDirectoryEntry!
    var readOnly: Bool!
    
    let groupsFirRef = Database.database().reference(withPath: "Groups")
    let usersRef = Database.database().reference(withPath: "Users")
    
    var currentGroupRef: DatabaseReference!
    var currentUserRef: DatabaseReference!
    
    @IBOutlet var groupName: UITextField!
    @IBOutlet var groupDescription: UITextView!
    @IBOutlet var newMeetingButton: UIButton!
    @IBOutlet var pastMeetingsButton: UIButton!
    @IBOutlet var editDetailsButton: UIButton!
    @IBOutlet var membersButton: UIButton!
    
    func recordMeeting(newMeeting: MeetingNotes?, nextAgenda: Agenda) {
        if let newNotes = newMeeting {
            self.group.meetingHistory.history.append(newNotes)
        }
        
        print("Next agenda title on arrival \(nextAgenda.title)")
        
        self.group.upcomingAgenda = nextAgenda
        print("upcoming agenda's title after transfer \(group.upcomingAgenda.title)")
//        self.group.save()
        currentGroupRef.setValue(group.jsonObject)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        super.loadView()
        
        groupName.text = group.name
        groupDescription.text = group.description
        currentGroupRef = groupsFirRef.child(group.groupID.uuidString)
        currentUserRef = usersRef.child(user.id)
        
        groupName.isUserInteractionEnabled = false
        
        newMeetingButton.layer.cornerRadius = 7
        newMeetingButton.layer.borderWidth = 1
        newMeetingButton.layer.borderColor = UIColor.lightGray.cgColor
        
        pastMeetingsButton.layer.cornerRadius = 7
        pastMeetingsButton.layer.borderWidth = 1
        pastMeetingsButton.layer.borderColor = UIColor.lightGray.cgColor
        
        editDetailsButton.layer.cornerRadius = 7
        editDetailsButton.layer.borderWidth = 1
        editDetailsButton.layer.borderColor = UIColor.lightGray.cgColor

        membersButton.layer.cornerRadius = 7
        membersButton.layer.borderWidth = 1
        membersButton.layer.borderColor = UIColor.lightGray.cgColor
        
        if readOnly == true {
            newMeetingButton.isHidden = true
            editDetailsButton.isHidden = true
            membersButton.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        groupName.text = group.name
        groupDescription.text = group.description
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "PastMeetings"?:
            let meetingHistory = segue.destination as! PastMeetingsViewController
            meetingHistory.meetingHistory = group.meetingHistory
        case "NewMeeting"?:
            let newMeeting = segue.destination as! NewMeetingViewController
            newMeeting.agenda = group.upcomingAgenda
            newMeeting.delegate = self
        case "GroupDetails"?:
            let details = segue.destination as! EditGroupDetailsViewController
            details.delegate = self
            details.name = group.name
            details.details = group.description
        case "membersSegue"?:
            let membersView = segue.destination as! MembersViewController
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

    func editDetails(name: String, details: String) {
        group.name = name
        group.description = details
        
        groupName.text = name
        groupDescription.text = details
        
        groupRef.name = name
        
        currentGroupRef.setValue(group.jsonObject)
        currentUserRef.setValue(user.jsonObject)
//        group.save()
//        user.save()
        
        
    }
    
}

