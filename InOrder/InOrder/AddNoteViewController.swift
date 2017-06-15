//
//  AddNoteViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/9/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class AddNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var delegate: MotionDelegate!
    var general: Bool!
    
    @IBOutlet var noteName: UITextField!
    @IBOutlet var noteText: UITextView!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    
    override func loadView() {
        super.loadView()
        
        noteName.text = "Add Name"
        noteText.text = "Add Note"
        
        recordButton.layer.cornerRadius = 7
        recordButton.layer.borderWidth = 1
        recordButton.layer.borderColor = UIColor.lightGray.cgColor
        
        cancelButton.layer.cornerRadius = 7
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        
        view.endEditing(true)
    }
    
    @IBAction func tapToEndEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func record(_ sender: UIButton) {
        delegate.recordNote(name: noteName.text!, description: noteText.text, general: general)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
