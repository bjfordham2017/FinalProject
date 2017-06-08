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
    
    
    @IBOutlet var agendaTable: UITableView!
    @IBOutlet var instructions: UITextView!
    @IBOutlet var beginMeeting: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agenda.agenda.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaCell", for: indexPath)
        
        cell.textLabel?.text = agenda.agenda[indexPath.row].name
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructions.text = "Build an agenda for this group's next meeting.  Add items with the 'Add Item' button, remove items by swiping, and add or edit titles and descriptions by tapping the item you want. Tap 'Begin Meeting' to begin your meeting walkthrough."
        
        instructions.isEditable = false
        
        if agenda.agenda.isEmpty {
            beginMeeting.isHidden = true
        }
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let newItem = AgendaItem(name: "Tap to Add Name", description: "Tap to edit description")
        agenda.agenda.append(newItem)
        if let index = agenda.agenda.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            agendaTable.insertRows(at: [indexPath], with: .automatic)
        }

        
    }
    
}
