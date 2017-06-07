//
//  ViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var group: Group!
    
    @IBOutlet var groupName: UITextField!
    @IBOutlet var groupDescription: UITextField!
    
    override func loadView() {
        super.loadView()
        
        
        groupName.text = group.name
        groupDescription.text = group.description
        
        group.meetingHistory.history.append(MeetingNotes(date: Date()))
        group.meetingHistory.history[0].generalNotes.append(Note(name: "Note Name", note: "Note Description"))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        group.name = groupName.text ?? ""
        group.description = groupDescription.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        group.name = groupName.text ?? ""
        group.description = groupDescription.text ?? ""
        return true
    }

    @IBAction func tapOutofEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        group.name = groupName.text ?? ""
        group.description = groupDescription.text ?? ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "PastMeetings"?:
                let meetingHistory = segue.destination as! PastMeetingsViewController
                meetingHistory.meetingHistory = group.meetingHistory
            case "NewMeeting"?:
                let newMeeting = segue.destination as! NewMeetingViewController
                newMeeting.agenda = group.upcomingAgenda
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

}

