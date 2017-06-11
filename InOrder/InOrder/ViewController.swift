//
//  ViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, MeetingDelegate {

    var group: Group!
    
    @IBOutlet var groupName: UITextField!
    @IBOutlet var groupDescription: UITextField!
    
    func recordMeeting(newMeeting: MeetingNotes?, nextAgenda: Agenda) {
        if let newNotes = newMeeting {
            self.group.meetingHistory.history.append(newNotes)
        }
        
        self.group.upcomingAgenda = nextAgenda
        
        dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        super.loadView()
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
                newMeeting.delegate = self
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

}

