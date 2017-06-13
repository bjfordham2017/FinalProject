//
//  MotionToAmendViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/9/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class MotionToAmendViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    var delegate: MotionDelegate!
    
    @IBOutlet var amendmentTitle: UITextField!
    @IBOutlet var amendmentText: UITextView!
    @IBOutlet var amendmentDirections: UITextView!
    
    
    override func loadView() {
        super.loadView()
        
        amendmentTitle.text = "Add a Title"
        amendmentText.text = "Add the Text of the Amendment"
        amendmentDirections.isEditable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }
    
    @IBAction func pass(_ sender: UIButton) {
        delegate.recordAmendment(name: amendmentTitle.text!, description: amendmentText.text)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fail(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapToEndEditing(_ sender: Any) {
        view.endEditing(true)
    }
    
}
