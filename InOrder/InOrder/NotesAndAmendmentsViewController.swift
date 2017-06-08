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
    
    var notes: [Note]!
    var amendments: [Note]!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return notes.count
        case 1:
            return amendments.count
        default:
            fatalError("unexpected section index")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteAmendmentCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = notes[indexPath.row].name
        }
        
        if indexPath.section == 1 {
            cell.textLabel?.text = amendments[indexPath.row].name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if !notes.isEmpty {
                return "Notes"
            } else {
                return "No notes for this item"
            }
        case 1:
            if !amendments.isEmpty {
                return "Amendments"
            } else {
                return "No amendments passed on this item"
            }
        default:
            print("unexpected section index")
            return nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = tableView.indexPathForSelectedRow?.row,
            let section = tableView.indexPathForSelectedRow?.section {
            
            var itemResultArray: [Note] {
                switch section {
                case 0:
                    return notes
                case 1:
                    return amendments
                default:
                    fatalError("Unexpected section index")
                }
            }
            
            let noteDetail = segue.destination as! NoteDetailViewController
            noteDetail.note = itemResultArray[row]            
        }

    }
}
