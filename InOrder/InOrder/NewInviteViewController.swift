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
    var selectedInvitee: Member! {
        willSet {
            if newValue != nil {
                print("Success!!!")
            }
        }
    }
    var inviteeRef: UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchByEmail(address: "bjfordham@presby.edu")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
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
        
        self.inviteeRef = usersRef.child(pathSafeAddress).observe(.value, with: {snapshot in
            if snapshot.exists() {
                self.selectedInvitee = Member(snapshot: snapshot)
            }
        })
    }
}
