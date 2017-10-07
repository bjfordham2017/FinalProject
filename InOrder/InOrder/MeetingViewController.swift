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
    @IBOutlet var proceedToHistory: UIButton!
    @IBOutlet var recess: UIButton!
    @IBOutlet var generalNotes: UIButton!
    @IBOutlet var adjourn: UIButton!
    @IBOutlet var addNote: UIButton!
    @IBOutlet var motionToAmend: UIButton!
    @IBOutlet var review: UIButton!
    @IBOutlet var table: UIButton!
    @IBOutlet var closeAndVote: UIButton!
    
    var delegate: MeetingWalkthroughDelegate!
    
    var agenda: Agenda!
    var newNotes: MeetingNotes!
    
    var itemIndex: Int = 0
    var currentItem: AgendaItem {
        return agenda.agenda[itemIndex]
    }
    
    override func loadView() {
        super.loadView()
        
        nameField.text = currentItem.name
        descriptionView.text = currentItem.description
        
        nameField.isUserInteractionEnabled = false
        descriptionView.isEditable = false
        
        proceedToHistory.isHidden = true
        
        proceedToHistory.layer.cornerRadius = 7
        proceedToHistory.layer.borderWidth = 1
        proceedToHistory.layer.borderColor = UIColor.lightGray.cgColor
        
        recess.layer.cornerRadius = 7
        recess.layer.borderWidth = 1
        recess.layer.borderColor = UIColor.lightGray.cgColor
        
        generalNotes.layer.cornerRadius = 7
        generalNotes.layer.borderWidth = 1
        generalNotes.layer.borderColor = UIColor.lightGray.cgColor
        
        adjourn.layer.cornerRadius = 7
        adjourn.layer.borderWidth = 1
        adjourn.layer.borderColor = UIColor.lightGray.cgColor
        
        addNote.layer.cornerRadius = 7
        addNote.layer.borderWidth = 1
        addNote.layer.borderColor = UIColor.lightGray.cgColor
        
        review.layer.cornerRadius = 7
        review.layer.borderWidth = 1
        review.layer.borderColor = UIColor.lightGray.cgColor
        
        motionToAmend.layer.cornerRadius = 7
        motionToAmend.layer.borderWidth = 1
        motionToAmend.layer.borderColor = UIColor.lightGray.cgColor
        
        table.layer.cornerRadius = 7
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.lightGray.cgColor
        
        closeAndVote.layer.cornerRadius = 7
        closeAndVote.layer.borderWidth = 1
        closeAndVote.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "recessSegue"?:
            let nav = segue.destination as! MeetingNavViewController
            let modal = nav.topViewController as! PassFailMotionViewController
            modal.delegate = self
            modal.motionType = .recess
        case "adjournSegue"?:
            let nav = segue.destination as! MeetingNavViewController
            let modal = nav.topViewController as! PassFailMotionViewController
            modal.delegate = self
            modal.motionType = .adjourn
        case "generalNoteSegue"?:
            let modal = segue.destination as! AddNoteViewController
            modal.delegate = self
            modal.general = true
        case "tableSegue"?:
            let nav = segue.destination as! MeetingNavViewController
            let modal = nav.topViewController as! PassFailMotionViewController
            modal.delegate = self
            modal.motionType = .table
        case "closeAndVoteSegue"?:
            let nav = segue.destination as! MeetingNavViewController
            let modal = nav.topViewController as! CloseAndVoteViewController
            modal.delegate = self
        case "addNoteSegue"?:
            let modal = segue.destination as! AddNoteViewController
            modal.delegate = self
            modal.general = false
        case "motionToAmendSegue"?:
            let nav = segue.destination as! MeetingNavViewController
            let modal = nav.topViewController as! MotionToAmendViewController
            modal.delegate = self
        case "reviewSegue"?:
            let noteList = segue.destination as! NotesAndAmendmentsViewController
            noteList.notes = currentItem.notes
            noteList.amendments = currentItem.amendments
            noteList.meetingInProgress = true
            noteList.generalNotes = newNotes.generalNotes
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    func closeMeeting() {
        var savedForNext = [AgendaItem]()
        for item in agenda.agenda {
            
            if item.status == .passed {
                newNotes.itemsPassed.append(item)
            } else if item.status == .failed {
                newNotes.itemsFailed.append(item)
            } else if item.status == .tabled {
                newNotes.itemsTabled.append(item)
                savedForNext.append(item)
            } else {
                savedForNext.append(item)
            }
        }
        
        self.agenda.agenda = savedForNext
        
    }
    
    func passFail(motion: Motions, result: Bool) {
        switch (motion, result) {
        case (.recess, _):
            return
        case (.adjourn, true):
            closeMeeting()
        case (.adjourn, false):
            return
        default:
            print("Motions to \(motion) are called on the main motion")
        }
    }
    
    func recordNote(name: String, description: String, general: Bool) {
        let noteToAdd = Note(name: name, note: description)
        
        self.newNotes.generalNotes.append(noteToAdd)
        
    }
    
    func cancelMotion() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishMeeting(_ sender: UIButton) {
        delegate.transferMeetingInfo(newMeeting: newNotes, nextAgenda: agenda)
    }
    
}


