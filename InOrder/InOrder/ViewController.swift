//
//  ViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, MeetingDelegate, GroupDetailDelegate {

    var group: Group!
    
    @IBOutlet var groupName: UITextField!
    @IBOutlet var groupDescription: UITextView!
    
    func recordMeeting(newMeeting: MeetingNotes?, nextAgenda: Agenda) {
        if let newNotes = newMeeting {
            self.group.meetingHistory.history.append(newNotes)
        }
        
        self.group.upcomingAgenda = nextAgenda
        
        dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        super.loadView()
        
        groupName.text = group.name
        groupDescription.text = group.description
        
        groupName.isUserInteractionEnabled = false
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
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

    func editDetails(name: String, details: String) {
        group.name = name
        group.description = details
        
        groupName.text = name
        groupDescription.text = details
    }
    
}

