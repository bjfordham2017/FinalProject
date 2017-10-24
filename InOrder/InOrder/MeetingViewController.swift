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

    @IBOutlet var recess: UIButton!
    @IBOutlet var generalNotes: UIButton!
    @IBOutlet var adjourn: UIButton!
    @IBOutlet var review: UIButton!
    @IBOutlet var meetingTitle: UITextField!
    @IBOutlet var meetingDate: UITextField!
    
    var delegate: MeetingWalkthroughDelegate!
    
    var agenda: Agenda!
    var newNotes: MeetingNotes!
    
    override func loadView() {
        super.loadView()
        
        meetingTitle.text = agenda.title
        meetingDate.text = MeetingNotes.dateFormatter.string(from: Date())
        
        newNotes = MeetingNotes(title: agenda.title, date: Date())
        
        recess.layer.cornerRadius = 7
        recess.layer.borderWidth = 1
        recess.layer.borderColor = UIColor.lightGray.cgColor
        
        generalNotes.layer.cornerRadius = 7
        generalNotes.layer.borderWidth = 1
        generalNotes.layer.borderColor = UIColor.lightGray.cgColor
        
        adjourn.layer.cornerRadius = 7
        adjourn.layer.borderWidth = 3
        adjourn.layer.borderColor = UIColor.black.cgColor
        
        review.layer.cornerRadius = 7
        review.layer.borderWidth = 1
        review.layer.borderColor = UIColor.lightGray.cgColor
        
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
        case "reviewSegue"?:
            let noteList = segue.destination as! NotesAndAmendmentsViewController
            noteList.generalNoteRequest = true
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
        print("title at closeMeeting \(agenda.title)")
        self.delegate.transferMeetingInfo(newMeeting: newNotes, nextAgenda: agenda)
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
    
}


