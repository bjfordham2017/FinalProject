//
//  NoteDetailViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/7/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class NoteDetailViewController: UIViewController, UINavigationControllerDelegate {
    var note: Note! {
        didSet {
            navigationItem.title = note.name
        }
    }
    
    @IBOutlet var noteText: UITextView!
    
    override func loadView() {
        super.loadView()
        noteText.text = note.note
        
        noteText.isEditable = false
    }
}
