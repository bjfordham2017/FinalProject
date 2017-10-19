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
    var newUserListener: AuthStateDidChangeListenerHandle!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var cancelButton: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fakeDirectoryEntry = GroupDirectoryEntry(name: "FakeGroup", id: UUID())
        let dictionaryEntryPoser = GroupDirectoryEntry(name: "I'm only pretending to be in this group", id: UUID())
        self.newUserListener = Auth.auth().addStateDidChangeListener({auth, user in
            guard let newUser = user else {
                return
            }
            let newInOrderUser = InOrderUser(name: self.nameField.text!, email: newUser.email!, id: newUser.uid, groupDirectory: [fakeDirectoryEntry], readOnlyGroupDirectory: [dictionaryEntryPoser])
            let newUserRef = self.userRef.child(newUser.uid)
            newUserRef.setValue(newInOrderUser.jsonObject)
            
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
