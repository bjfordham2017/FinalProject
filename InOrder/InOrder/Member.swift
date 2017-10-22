//
//  Member.swift
//  InOrder
//
//  Created by Brent Fordham on 10/10/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import Firebase

class Member {
    let name: String
    let email: String
    let id: String
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        
        output[Member.nameLabel] = self.name
        output[Member.emailLabel] = self.email
        output[Member.idLabel] = self.id
        
        return output

    }
    
    init (name: String, email: String, id: String) {
        self.name = name
        self.email = email
        self.id = id
    }
    
    convenience init? (jsonObject: [String:Any]) {
        guard let name = jsonObject[Member.nameLabel] as? String,
        let email = jsonObject[Member.emailLabel] as? String,
        let id = jsonObject[Member.idLabel] as? String else {
            return nil
        }
        self.init(name: name, email: email, id: id)

    }
    
    convenience init? (snapshot: DataSnapshot) {
        guard let jsonObject = snapshot.value as? [String:Any],
        let name = jsonObject[Member.nameLabel] as? String,
        let email = jsonObject[Member.emailLabel] as? String,
            let id = jsonObject[Member.idLabel] as? String else {
                return nil
        }
        self.init(name: name, email: email, id: id)
    }
    
    public static let nameLabel = "Name"
    public static let idLabel = "ID"
    public static let emailLabel = "Email"

    
}
