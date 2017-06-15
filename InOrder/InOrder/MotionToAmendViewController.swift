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
    @IBOutlet var passButton: UIButton!
    @IBOutlet var failButton: UIButton!
    
    
    override func loadView() {
        super.loadView()
        
        amendmentTitle.text = "Add a Title"
        amendmentText.text = "Add the Text of the Amendment"
        amendmentDirections.isEditable = false
        
        passButton.layer.cornerRadius = 7
        passButton.layer.borderWidth = 1
        passButton.layer.borderColor = UIColor.lightGray.cgColor
        
        failButton.layer.cornerRadius = 7
        failButton.layer.borderWidth = 1
        failButton.layer.borderColor = UIColor.lightGray.cgColor

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
