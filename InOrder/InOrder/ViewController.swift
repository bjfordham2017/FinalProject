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
        group.meetingHistory.history[0].generalNotes.append(Note(name: "Note Name", note: "Note Description.  A description of a note describing the note that is described herein, in this case that this note is in fact a note, and its description is in fact a description of said note which we have contrived to describe.  That's a terrible description, to say nothing of terrible sentence, and we should change it soon."))
        
        let passedAgendaItem = AgendaItem(name: "Passed", description: "Now it's off for the presidential veto")
        passedAgendaItem.inputVoteTally(votesFor: 5, votesAgainst: 3, abstained: 1)
        passedAgendaItem.amendments.append(Note(name: "Iffy Amendment", note: "The amendment that renders the bill very iffy."))
        let failedAgendaItem = AgendaItem(name: "Failed", description: "Parliment don't play that!")
        failedAgendaItem.inputVoteTally(votesFor: 1, votesAgainst: 5, abstained: 3)
        let tabledAgendaItem = AgendaItem(name: "Tabled", description: "We'll talk about it next time")
        tabledAgendaItem.table()
        let failedByDefaulAgendaItem = AgendaItem(name: "Fails by default", description: "Everyone abstained")
        failedByDefaulAgendaItem.inputVoteTally(votesFor: 0, votesAgainst: 0, abstained: 9)

        group.meetingHistory.history[0].itemsPassed.append(passedAgendaItem)
        group.meetingHistory.history[0].itemsFailed.append(failedAgendaItem)
        group.meetingHistory.history[0].itemsFailed.append(failedByDefaulAgendaItem)
        group.meetingHistory.history[0].itemsTabled.append(tabledAgendaItem)
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

