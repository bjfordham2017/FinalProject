//
//  MeetingViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class MeetingViewController: UIViewController, MotionDelegate {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var descriptionView: UITextView!
    
    var agenda: Agenda!
    var newNotes: MeetingNotes!
    var history: MeetingHistory!
    
    var itemIndex: Int = 0
    var currentItem: AgendaItem {
        return agenda.agenda[itemIndex]
    }
    
    override func loadView() {
        super.loadView()
        
        //navigationItem.hidesBackButton = true  I don't want to implement this until I'm absolutely certain I can escape with my Adjourn key.
        
        nameField.text = currentItem.name
        descriptionView.text = currentItem.description
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "recessSegue"?:
            let modal = segue.destination as! PassFailMotionViewController
            modal.delegate = self
            modal.motionType = .recess
        case "adjournSegue"?:
            let modal = segue.destination as! PassFailMotionViewController
            modal.delegate = self
            modal.motionType = .adjourn
        case "generalNoteSegue"?:
            let modal = segue.destination as! AddNoteViewController
            modal.delegate = self
            modal.general = true
        case "tableSegue"?:
            let modal = segue.destination as! PassFailMotionViewController
            modal.delegate = self
            modal.motionType = .table
        case "closeAndVoteSegue"?:
            let modal = segue.destination as! CloseAndVoteViewController
            modal.delegate = self
        case "addNoteSegue"?:
            let modal = segue.destination as! AddNoteViewController
            modal.delegate = self
            modal.general = false
        case "motionToAmendSegue"?:
            let modal = segue.destination as! MotionToAmendViewController
            modal.delegate = self
        case "reviewSegue"?:
            let noteList = segue.destination as! NotesAndAmendmentsViewController
            noteList.notes = currentItem.notes
            noteList.amendments = currentItem.amendments
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func closeAndVote(_ sender: UIButton) {
        itemIndex += 1
        if itemIndex == agenda.agenda.count {
            itemIndex = 0
        }
        
        nameField.text = currentItem.name
        descriptionView.text = currentItem.description
        
    }
 
    func tally(votefor: Int, voteagainst: Int, abstension: Int) {
        self.currentItem.inputVoteTally(votesFor: votefor, votesAgainst: voteagainst, abstained: abstension)
    }
    
    func passFail(motion: Motions, result: Bool) {
        switch (motion, result) {
        case (.recess, _):
            return
        case (.table, true):
            currentItem.table()
        case (.table, false):
            return
        case (.adjourn, true):
            return
        case (.adjourn, false):
            return
        default:
            print("Motions to \(motion) are not simple pass/fail motions")
        }
    }
    
    func recordNote(name: String, description: String, general: Bool) {
        let noteToAdd = Note(name: name, note: description)
        
        if general {
            self.newNotes.generalNotes.append(noteToAdd)
        } else {
            self.currentItem.notes.append(noteToAdd)
        }
        
    }
    
    func recordAmendment(name: String, description: String) {
        let amendment = Note(name: name, note: description)
        self.currentItem.amendments.append(amendment)
    }

    
}


