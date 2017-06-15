//
//  CloseAndVoteViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/9/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class CloseAndVoteViewController: UIViewController, UITextFieldDelegate {
    var delegate: MotionDelegate!
    
    
    @IBOutlet var votesFor: UITextField!
    @IBOutlet var votesAgainst: UITextField!
    @IBOutlet var abstentions: UITextField!
    @IBOutlet var voteDirections: UITextView!
    @IBOutlet var returnButton: UIButton!
    @IBOutlet var recordButton: UIButton!
    
    override func loadView() {
        super.loadView()
        
        voteDirections.isEditable = false
        
        returnButton.layer.cornerRadius = 7
        returnButton.layer.borderWidth = 1
        returnButton.layer.borderColor = UIColor.lightGray.cgColor
        
        recordButton.layer.cornerRadius = 7
        recordButton.layer.borderWidth = 1
        recordButton.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }
    
    
    @IBAction func tapToEndEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func returnToDebate(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finalVote(_ sender: UIButton) {
        guard let vfor = Int(votesFor.text!),
            let vagainst = Int(votesAgainst.text!),
            let abstain = Int(abstentions.text!)
            else {
                return
        }
        
        view.endEditing(true)
        
        delegate.tally(votefor: vfor, voteagainst: vagainst, abstension: abstain)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
