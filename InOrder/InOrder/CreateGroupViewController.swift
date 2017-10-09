//
//  CreateGroupViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/9/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class CreateGroupViewController: UIViewController {

    @IBOutlet var groupNameField: UITextField!
    @IBOutlet var groupDetailsField: UITextView!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    var user: User!
    var newGroup: Group!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupNameField.placeholder = "Name your group"
        groupDetailsField.text = "Enter a brief description and other details here"
        
        createButton.layer.cornerRadius = 7
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.lightGray.cgColor
        
        cancelButton.layer.cornerRadius = 7
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    @IBAction func createGroup(_ sender: UIButton) {
        view.endEditing(true)
        newGroup.name = groupNameField.text ?? "New Group"
        newGroup.description = groupDetailsField.text ?? "New Group"
        let newGroupRef = GroupDirectoryEntry(name: newGroup.name, id: newGroup.groupID)
        user.groupDirectory.append(newGroupRef)
        user.save()
        newGroup.save()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapToEndEditing(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
        newGroup.name = groupNameField.text ?? "New Group"
        newGroup.description = groupDetailsField.text ?? "New Group"
    }

    
}