//
//  LogInViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/17/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LogInViewController: UIViewController {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    
    var isUserLoggedIn: AuthStateDidChangeListenerHandle!
    var currentUser: InOrderUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        
        print("Loaded!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(isUserLoggedIn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isUserLoggedIn = Auth.auth().addStateDidChangeListener({auth, user in
            if user != nil {
                print("User currently logged in")
                let usersRef = Database.database().reference(withPath: "Users")
                let currentUserRef = usersRef.child(user!.uid)
                currentUserRef.observe(.value, with: {snapshot in
                    self.currentUser = InOrderUser(dataSnapshot: snapshot)
                    if self.currentUser != nil {
                        self.performSegue(withIdentifier: "logInSegue", sender: nil)
                    }
                })
            }
        })
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!, completion: nil)
    }
    
    @IBAction func register(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "logInSegue":
            let nav = segue.destination as! UINavigationController
            let userView = nav.topViewController as! UserMenuViewController
            if let userLoggedIn = self.currentUser {
                userView.user = userLoggedIn
            }
        case "registerSegue":
            let registerView = segue.destination as! RegisterViewController
        default:
            preconditionFailure("Unexpected Segue Identifier")
        }
    }
    
}
