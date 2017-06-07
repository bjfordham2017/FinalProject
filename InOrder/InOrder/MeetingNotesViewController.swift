//
//  MeetingNotesViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/6/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class MeetingNotesViewController: UITableViewController, UINavigationControllerDelegate {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var meetingNotes: MeetingNotes! {
        didSet {
            navigationItem.title = dateFormatter.string(from: meetingNotes.date)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return meetingNotes.generalNotes.count
        case 1:
            return meetingNotes.itemsPassed.count
        case 2:
            return meetingNotes.itemsFailed.count
        case 3:
            return meetingNotes.itemsTabled.count
        default:
            preconditionFailure("unexpected section index")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if !meetingNotes.generalNotes.isEmpty {
                return "General Notes"
            } else {
                return "No notes from this meeting"
            }
        case 1:
            if !meetingNotes.itemsPassed.isEmpty {
                return "Passed Items"
            } else {
                return "No items passed at this meeting"
            }
        case 2:
            if !meetingNotes.itemsFailed.isEmpty {
                return "Failed Items"
            } else {
                return "No items failed at this meeting"
            }
        case 3:
            if !meetingNotes.itemsTabled.isEmpty {
                return "Tabled Items"
            } else {
                return "No Items tabled at this meeting"
            }
        default:
            print("Unexpected section index")
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            let note = meetingNotes.generalNotes[indexPath.row]
            cell.textLabel?.text = note.name
        case 1:
            let passed = meetingNotes.itemsPassed[indexPath.row]
            cell.textLabel?.text = passed.name
        case 2:
            let failed = meetingNotes.itemsFailed[indexPath.row]
            cell.textLabel?.text = failed.name
        case 3:
            let tabled = meetingNotes.itemsTabled[indexPath.row]
            cell.textLabel?.text = tabled.name
        default:
            fatalError("unexpected section index")
        }
        
        return cell
    }

    
}
