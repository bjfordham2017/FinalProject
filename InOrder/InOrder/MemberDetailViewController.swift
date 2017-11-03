//
//  MemberDetailViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/10/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class MemberDetailViewController: UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var dismissButton: UIButton!
    
    
    var member: Member!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = member.name
        emailField.text = member.email
        
        dismissButton.layer.cornerRadius = 7
        dismissButton.layer.borderWidth = 1
        dismissButton.layer.borderColor = UIColor.lightGray.cgColor
        dismissButton.isHidden = true
        
    }
    
}
