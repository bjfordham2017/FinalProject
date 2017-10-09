//
//  NotesAndAmendmentsViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class NotesAndAmendmentsViewController: UITableViewController {
    
    var notes: [Note]?
    var amendments: [Note]?
    
    var generalNoteRequest: Bool = false
    var generalNotes: [Note]?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if generalNoteRequest {
            return 1
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section, self.generalNoteRequest) {
        case (0, false):
            return notes!.count
        case (1, _):
            return amendments!.count
        case (0, true):
            if let general = generalNotes {
                return general.count
            } else {
                return 0
            }
        default:
            fatalError("unexpected section index")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteAmendmentCell", for: indexPath)
        
        if indexPath.section == 0 && generalNoteRequest == false {
            cell.textLabel?.text = notes![indexPath.row].name
        }
        
        if indexPath.section == 1 {
            cell.textLabel?.text = amendments![indexPath.row].name
        }
        
        if indexPath.section == 0 && generalNoteRequest == true {
            cell.textLabel?.text = generalNotes![indexPath.row].name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section, generalNoteRequest) {
        case (0, false):
            if !notes!.isEmpty {
                if notes!.count == 1 {
                    return "\(notes!.count) Note"
                } else {
                    return "\(notes!.count) Notes"
                }
            } else {
                return "No notes for this item"
            }
        case (1, _):
            if !amendments!.isEmpty {
                if amendments!.count == 1 {
                    return "\(amendments!.count) Amendment"
                } else {
                    return "\(amendments!.count) Amendments"
                }
            } else {
                return "No amendments passed on this item"
            }
        case (0, true):
            if let general = generalNotes {
                if !general.isEmpty {
                    if general.count == 1 {
                        return "\(general.count) General Meeting Note"
                    } else {
                        return "\(general.count) General Meeting Notes"
                    }
                } else {
                    return "No general notes for this meeting so far"
                }
            } else {
                return nil
            }
        default:
            print("unexpected section index")
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = tableView.indexPathForSelectedRow?.row,
            let section = tableView.indexPathForSelectedRow?.section {
            
            var itemResultArray: [Note] {
                switch (section, generalNoteRequest) {
                case (0, false):
                    return notes!
                case (1, _):
                    return amendments!
                case (0, true):
                    return generalNotes!
                default:
                    fatalError("Unexpected section index")
                }
            }
            
            let noteDetail = segue.destination as! NoteDetailViewController
            noteDetail.note = itemResultArray[row]            
        }

    }
}
