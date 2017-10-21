//
//  NewInviteViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/10/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NewInviteViewController: UIViewController {
    let usersRef = Database.database().reference(withPath: "AllMembers")
    var inviteeRef: DatabaseReference!
    var inviteeObserver: UInt!
    var userToInvite: Member?
    var groupSendingInvite: Group!
    
    @IBOutlet var searchField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if userToInvite != nil {
            userToInvite = nil
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if inviteeRef != nil {
            inviteeRef.removeObserver(withHandle: inviteeObserver)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "searchResultsSegue":
            let resultsView = segue.destination as! SearchResultsViewController
            if let newMember = self.userToInvite {
                resultsView.userToInvite = newMember
            }
            resultsView.groupName = self.groupSendingInvite.name
            resultsView.groupID = self.groupSendingInvite.groupID
        default:
            fatalError("Unexpected Segue Identifier")
        }
    }
    
    func pathSafeEmail(_ input: String) -> String {
        let pathSafeArray = input.characters.map({character -> Character in
            switch character {
            case ".":
                return ","
            default:
                return character
            }
        })
        
        let pathSafeString = String(pathSafeArray)
        
        return pathSafeString
    }
    
    func searchByEmail(address: String) {
        
        let pathSafeAddress = pathSafeEmail(address)
        
        self.inviteeRef = usersRef.child(pathSafeAddress)
        self.inviteeObserver = inviteeRef.observe(.value, with: {snapshot in
            if snapshot.exists() {
                self.userToInvite = Member(snapshot: snapshot)
                if self.userToInvite != nil {
                    self.performSegue(withIdentifier: "searchResultsSegue", sender: nil)
                }
            }
        })
    }
    
    @IBAction func search(_ sender: UIButton) {
        let enteredAddress = searchField.text!
        searchByEmail(address: enteredAddress)
    }
}
