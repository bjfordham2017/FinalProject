//
//  MeetingViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class MeetingViewController: UIViewController {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var descriptionView: UITextView!
    
    var agenda: Agenda!
    var newNotes: MeetingNotes!
    var history: MeetingHistory!
    
    var itemIndex: Int = 0
    var currentItem: AgendaItem {
        return agenda.agenda[itemIndex]
    }
    
    override func loadView() {
        super.loadView()
        
        //navigationItem.hidesBackButton = true  I don't want to implement this until I'm absolutely certain I can escape with my Adjourn key.
        
        nameField.text = currentItem.name
        descriptionView.text = currentItem.description
        
    }
    
    @IBAction func closeAndVote(_ sender: UIButton) {
        itemIndex += 1
        if itemIndex == agenda.agenda.count {
            itemIndex = 0
        }
        
        nameField.text = currentItem.name
        descriptionView.text = currentItem.description
        
    }
    
}


