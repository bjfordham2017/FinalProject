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

    @IBAction func createGroup(_ sender: UIButton) {
        let newGroupRef = GroupDirectoryEntry(name: newGroup.name, id: newGroup.groupID)
        user.groupDirectory.append(newGroupRef)
        user.save()
        newGroup.save()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
