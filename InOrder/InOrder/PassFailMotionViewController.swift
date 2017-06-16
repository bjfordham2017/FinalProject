//
//  PassFailMotionViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/9/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class PassFailMotionViewController: UIViewController {
    var delegate: MotionDelegate!
    var motionType: Motions = .recess

    @IBOutlet var motionText: UITextView!
    @IBOutlet var passButton: UIButton!
    @IBOutlet var failButton: UIButton!
    
    override func loadView() {
        super.loadView()
        
        switch motionType {
        case .adjourn:
            motionText.text = "A motion to adjourn requires a second and a simple majority vote.  If you adjourn before the end of your planned agenda, any remaining items will appear in the list automatically when you prepare your next meeting."
        case .table:
            motionText.text = "A motion to table requires a second and a simple majority vote.  Tabled items are moved to the agenda for the following meeting."
        case .recess:
            motionText.text = "A motion to recess requires a second and a simple majority vote."
        default:
            motionText.text = "Error: \(motionType.description) is not a pass/fail motion. If this happens, it is a bug"
        }
        
        motionText.isEditable = false
        
        passButton.layer.cornerRadius = 7
        passButton.layer.borderWidth = 1
        passButton.layer.borderColor = UIColor.lightGray.cgColor
        
        failButton.layer.cornerRadius = 7
        failButton.layer.borderWidth = 1
        failButton.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    @IBAction func passMotion(_ sender: UIButton) {
        delegate.passFail(motion: motionType, result: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func failMotion(_ sender: UIButton) {
        delegate.passFail(motion: motionType, result: false)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelMotion(_ sender: UIBarButtonItem) {
        delegate.cancelMotion()
    }
    
}
