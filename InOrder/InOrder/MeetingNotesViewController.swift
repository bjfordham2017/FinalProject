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
    
    var meetingNotes: MeetingNotes! {
        didSet {
            navigationItem.title = meetingNotes.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.title = "Back"
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let output = UILabel()
        
        output.textColor = .black
        output.font = UIFont.boldSystemFont(ofSize: 20)
        output.textAlignment = .center
        
        switch section {
        case 0:
            if !meetingNotes.generalNotes.isEmpty {
                output.text = "General Notes"
            } else {
                output.text = "No notes from this meeting"
            }
        case 1:
            if !meetingNotes.itemsPassed.isEmpty {
                output.text = "Passed Items"
            } else {
                output.text = "No items passed at this meeting"
            }
        case 2:
            if !meetingNotes.itemsFailed.isEmpty {
                output.text = "Failed Items"
            } else {
                output.text = "No items failed at this meeting"
            }
        case 3:
            if !meetingNotes.itemsTabled.isEmpty {
                output.text = "Tabled Items"
            } else {
                output.text = "No Items tabled at this meeting"
            }
        default:
            fatalError("Unexpected section index")
        }

        
        return output
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(60)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell: UITableViewCell {
            switch indexPath.section {
            case 0:
                let noteCell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
                let note = meetingNotes.generalNotes[indexPath.row]
                noteCell.textLabel?.text = note.name
                return noteCell
            case 1:
                let passed = meetingNotes.itemsPassed[indexPath.row]
                let itemCell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)
                itemCell.textLabel?.text = passed.name
                return itemCell
            case 2:
                let failed = meetingNotes.itemsFailed[indexPath.row]
                let itemCell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)
                itemCell.textLabel?.text = failed.name
                return itemCell
            case 3:
                let tabled = meetingNotes.itemsTabled[indexPath.row]
                let itemCell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)
                itemCell.textLabel?.text = tabled.name
                return itemCell
        default:
            fatalError("unexpected section index")
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "noteDetailSegue"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let note = meetingNotes.generalNotes[row]
                let noteDetail = segue.destination as! NoteDetailViewController
                noteDetail.note = note
            }
        case "itemDetailSegue"?:
            if let row = tableView.indexPathForSelectedRow?.row,
                let section = tableView.indexPathForSelectedRow?.section {
                
                var itemResultArray: [AgendaItem] {
                    switch section {
                    case 1:
                        return meetingNotes.itemsPassed
                    case 2:
                        return meetingNotes.itemsFailed
                    case 3:
                        return meetingNotes.itemsTabled
                    default:
                        fatalError("Unexpected section index")
                    }
                }
                
                let itemDetail = segue.destination as! ItemDetailViewController
                itemDetail.item = itemResultArray[row]
                
            }
        default:
            fatalError("Unexpected segue identifier")
        }
    }
}
