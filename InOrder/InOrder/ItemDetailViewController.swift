//
//  ItemDetailViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/7/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailViewController: UIViewController {
    var item: AgendaItem! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    @IBOutlet var itemDescription: UITextView!
    @IBOutlet var itemStatus: UITextField!
    @IBOutlet var countFor: UITextField!
    @IBOutlet var countAgainst: UITextField!
    @IBOutlet var countAbstained: UITextField!
    
    @IBOutlet var notesAndAmendments: UIButton!
    
    
    override func loadView() {
        super.loadView()
        itemDescription.text = item.description
        itemStatus.text = item.status.description
        countFor.text = "\(item.votesFor)"
        countAgainst.text = "\(item.votesAgainst)"
        countAbstained.text = "\(item.abstentions)"
        
        navigationItem.leftBarButtonItem?.title = "Back"
        
        var notesOnButton: String {
            if item.notes.count == 1 {
                return "\(item.notes.count) Note"
            } else {
                return "\(item.notes.count) Notes"
            }
        }
        
        var amendmentsOnButton: String {
            if item.amendments.count == 1 {
                return "\(item.amendments.count) Amendment"
            } else {
                return "\(item.amendments.count) Amendments"
            }
        }
        
        notesAndAmendments.setTitle("\(notesOnButton) & \(amendmentsOnButton)", for: .normal)
        notesAndAmendments.layer.cornerRadius = 7
        notesAndAmendments.layer.borderWidth = 1
        notesAndAmendments.layer.borderColor = UIColor.lightGray.cgColor
        
        itemDescription.isEditable = false
        itemStatus.isUserInteractionEnabled = false
        countFor.isUserInteractionEnabled = false
        countAgainst.isUserInteractionEnabled = false
        countAbstained.isUserInteractionEnabled = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let notesAndAmendments = segue.destination as! NotesAndAmendmentsViewController
        notesAndAmendments.notes = item.notes
        notesAndAmendments.amendments = item.amendments
    }
}
