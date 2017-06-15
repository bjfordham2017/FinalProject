//
//  EditGroupDetailsViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/12/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class EditGroupDetailsViewController: UIViewController {
    
    var delegate: GroupDetailDelegate!
    var name: String!
    var details: String!
    
    @IBOutlet var groupName: UITextField!
    @IBOutlet var groupDetails: UITextView!
    @IBOutlet var doneEditing: UIButton!
    
    override func loadView() {
        super.loadView()
        
        groupName.text = name
        groupDetails.text = details
        
        doneEditing.layer.cornerRadius = 7
        doneEditing.layer.borderWidth = 1
        doneEditing.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }
    
    @IBAction func tapToEndEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    
    @IBAction func doneEditing(_ sender: UIButton) {
        let newName = groupName.text ?? "Name"
        let newDetails = groupDetails.text ?? "Details"
        delegate.editDetails(name: newName, details: newDetails)
        dismiss(animated: true, completion: nil)
    }
    
    
}
