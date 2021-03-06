//
//  RegisterViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/17/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController: UIViewController {
    let userRef = Database.database().reference(withPath: "Users")
    let allMembersRef = Database.database().reference(withPath: "AllMembers")
    var newUserListener: AuthStateDidChangeListenerHandle!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = 7
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.lightGray.cgColor
        
        cancelButton.layer.cornerRadius = 7
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.lightGray.cgColor
        
        self.newUserListener = Auth.auth().addStateDidChangeListener({auth, user in
            guard let newUser = user else {
                return
            }
            let newInOrderUser = InOrderUser(name: self.nameField.text!, email: newUser.email!, id: newUser.uid)
            let pathSafeEmail = newInOrderUser.email.characters.map({character -> Character in
                switch character {
                case ".":
                    return ","
                default:
                    return character
                }
            })
            let emailPath = String(pathSafeEmail)
            let newUserRef = self.userRef.child(newUser.uid)
            let newMemberRef = self.allMembersRef.child(emailPath)
            newUserRef.setValue(newInOrderUser.jsonObject)
            newMemberRef.setValue(newInOrderUser.memberOnlyJSONObject)
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(newUserListener)
    }
    
    @IBAction func register(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {user, error in
            if error == nil {
                Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: nil)
            }
        })
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
