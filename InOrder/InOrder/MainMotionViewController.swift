//
//  MainMotionViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/7/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import UIKit

class MainMotionViewController: UIViewController, MainMotionDelegate {
    
    var agenda: Agenda!
    var itemIndex: Int = 0
    var currentItem: AgendaItem {
        return agenda.agenda[itemIndex]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "closeAndVote":
            let nav = segue.destination as! MeetingNavViewController
            let voteView = nav.topViewController as! CloseAndVoteViewController
            voteView.delegate = self
        case "amend":
            let nav = segue.destination as! MeetingNavViewController
            let amendView = nav.topViewController as! MotionToAmendViewController
            amendView.delegate = self
        case "addNote":
            let noteView = segue.destination as! AddNoteViewController
            noteView.delegate = self
            noteView.general = false
        case "table":
            let nav = segue.destination as! MeetingNavViewController
            let tableMotionView = nav.topViewController as! PassFailMotionViewController
            tableMotionView.delegate = self
            tableMotionView.motionType = .table
        case "review":
            let noteList = segue.destination as! NotesAndAmendmentsViewController
            noteList.notes = currentItem.notes
            noteList.amendments = currentItem.amendments
            noteList.generalNoteRequest = false
        default:
            print("Unexpected Segue Identifier")
        }
    }
    
    func advance() {
        itemIndex += 1
        
        
        if itemIndex == agenda.agenda.count {
            itemIndex = 0
            agendaComplete()
        } else {
//            nameField.text = currentItem.name
//            descriptionView.text = currentItem.description
        }
    }
    
    func agendaComplete() {
//        descriptionView.text = "That's the end of your agenda.  You can now proceed to your notes for this meeting"
//
//        nameField.isHidden = true
//        recess.isHidden = true
//        generalNotes.isHidden = true
//        adjourn.isHidden = true
//        addNote.isHidden = true
//        motionToAmend.isHidden = true
//        review.isHidden = true
//        table.isHidden = true
//        closeAndVote.isHidden = true
        
//        proceedToHistory.isHidden = false
        
    }
    
    func tally(votefor: Int, voteagainst: Int, abstension: Int) {
        self.currentItem.inputVoteTally(votesFor: votefor, votesAgainst: voteagainst, abstained: abstension)
        
        advance()
    }
    
    func passFail(motion: Motions, result: Bool) {
        switch (motion, result) {
        case (.table, true):
            currentItem.table()
            advance()
        case (.table, false):
            return
        default:
            print("Motions to \(motion) are not called on main motions")
        }
    }
    
    func recordNote(name: String, description: String, general: Bool) {
        let noteToAdd = Note(name: name, note: description)
        
        self.currentItem.notes.append(noteToAdd)
        
    }
    
    func recordAmendment(name: String, description: String) {
        let amendment = Note(name: name, note: description)
        self.currentItem.amendments.append(amendment)
    }
    
    func cancelMotion() {
        dismiss(animated: true, completion: nil)
    }

}
