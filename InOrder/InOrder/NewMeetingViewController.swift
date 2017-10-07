//
//  NewMeetingViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/6/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class NewMeetingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MeetingWalkthroughDelegate {
    var agenda: Agenda!
    var delegate: MeetingDelegate!
    
    @IBOutlet var agendaTable: UITableView!
    @IBOutlet var beginMeeting: UIButton!
    @IBOutlet var editList: UIButton!
    @IBOutlet var addItem: UIButton!
    @IBOutlet var saveForLater: UIButton!
    
    func transferMeetingInfo(newMeeting: MeetingNotes?, nextAgenda: Agenda) {
        delegate.recordMeeting(newMeeting: newMeeting, nextAgenda: nextAgenda)
        dismiss(animated: true, completion: nil)
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
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
        
        if agenda.agenda.isEmpty {
            beginMeeting.isHidden = true
        }
        
        editList.layer.cornerRadius = 7
        editList.layer.borderWidth = 1
        editList.layer.borderColor = UIColor.lightGray.cgColor
        
        addItem.layer.cornerRadius = 7
        addItem.layer.borderWidth = 1
        addItem.layer.borderColor = UIColor.lightGray.cgColor
        
        saveForLater.layer.cornerRadius = 7
        saveForLater.layer.borderWidth = 1
        saveForLater.layer.borderColor = UIColor.lightGray.cgColor
        
        beginMeeting.layer.cornerRadius = 7
        beginMeeting.layer.borderWidth = 1
        beginMeeting.layer.borderColor = UIColor.lightGray.cgColor

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
    
    @IBAction func saveForLater(_ sender: UIButton) {
        transferMeetingInfo(newMeeting: nil, nextAgenda: agenda)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editSegue"?:
            if let row = agendaTable.indexPathForSelectedRow?.row {
                let itemEditView = segue.destination as! EditAgenaItemViewController
                itemEditView.item = agenda.agenda[row]
            }
        case "beginMeetingSegue"?:
            let meetingNav = segue.destination as! MeetingNavViewController
            let meetingTabBar = meetingNav.topViewController as! MeetingTabBarController
            meetingTabBar.meetingWalkThroughDelegate = self
            let meeting = meetingTabBar.customizableViewControllers![0] as! MeetingViewController
            meeting.agenda = self.agenda
            meeting.newNotes = MeetingNotes(date: Date())
            meeting.delegate = self
            let mainMotion = meetingTabBar.customizableViewControllers![1] as! MainMotionViewController
            mainMotion.agenda = self.agenda
        default:
            preconditionFailure("unexpected segue identifier")
        }
    }
    
}
