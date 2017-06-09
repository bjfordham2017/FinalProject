//
//  PastMeetingsViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/6/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class PastMeetingsViewController: UITableViewController {
    var meetingHistory: MeetingHistory!
    
    var meetingHistorySorted: [MeetingNotes] {
        return meetingHistory.history.reversed()
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetingHistorySorted.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastViewCell", for: indexPath)
        let notes = meetingHistorySorted[indexPath.row]
        
        cell.textLabel?.text = dateFormatter.string(from: notes.date)
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "MeetingSelection"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let meetingNotes = meetingHistorySorted[row]
                let notesView = segue.destination as! MeetingNotesViewController
                notesView.meetingNotes = meetingNotes
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

}
