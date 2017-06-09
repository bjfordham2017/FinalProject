//
//  NewMeetingViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/6/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class NewMeetingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var agenda: Agenda!
    var history: MeetingHistory!
    
    
    @IBOutlet var agendaTable: UITableView!
    @IBOutlet var instructions: UITextView!
    @IBOutlet var beginMeeting: UIButton!
    @IBOutlet var editList: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agenda.agenda.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaCell", for: indexPath)
        
        cell.textLabel?.text = agenda.agenda[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            agenda.agenda.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if agenda.agenda.isEmpty {
                beginMeeting.isHidden = true
            }
        }
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        agenda.arrangeAgenda(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructions.text = "Build an agenda for this group's next meeting.  Add items with the 'Add Item' button and add or edit titles and descriptions by tapping the item you want. You can also use 'Edit List' to toggle a mode for rearragning or deleting items. Tap 'Begin Walkthrough' when you are ready to consider your first order of business."
        
        instructions.isEditable = false
        
        if agenda.agenda.isEmpty {
            beginMeeting.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        agendaTable.reloadData()
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let newItem = AgendaItem(name: "Tap to Add Name", description: "Tap to edit description")
        agenda.agenda.append(newItem)
        if let index = agenda.agenda.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            agendaTable.insertRows(at: [indexPath], with: .automatic)
        }
        
        beginMeeting.isHidden = false
    }
    
    @IBAction func toggleEditing(_ sender: Any) {
        if !agendaTable.isEditing {
            agendaTable.setEditing(true, animated: true)
        } else {
            agendaTable.setEditing(false, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editSegue"?:
            if let row = agendaTable.indexPathForSelectedRow?.row {
                let itemEditView = segue.destination as! EditAgenaItemViewController
                itemEditView.item = agenda.agenda[row]
            }
        case "beginMeetingSegue"?:
            let meeting = segue.destination as! MeetingViewController
            meeting.agenda = self.agenda
            meeting.newNotes = MeetingNotes(date: Date())
            meeting.history = self.history
        default:
            preconditionFailure("unexpected segue identifier")
        }
    }
    
}
