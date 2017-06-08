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
    
    override func loadView() {
        super.loadView()
        itemDescription.text = item.description
        itemStatus.text = item.status.description
        countFor.text = "\(item.votesFor)"
        countAgainst.text = "\(item.votesAgainst)"
        countAbstained.text = "\(item.abstentions)"
        
        itemDescription.isEditable = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let notesAndAmendments = segue.destination as! NotesAndAmendmentsViewController
        notesAndAmendments.notes = item.notes
        notesAndAmendments.amendments = item.amendments
    }
}
