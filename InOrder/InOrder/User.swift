//
//  User.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class User {//needs explicit access control
    var group: Group = Group()
    let filePath: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("secondNewUser.json")
    }()

    
    init() {
        if let data = try? Data(contentsOf: filePath),
            let JSON = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonDictionary = JSON as? [String:Any] {
                self.group = Group(jsonDictionary: jsonDictionary)
        }
    }
    
    func save() {
        do {
            let data = try JSONSerialization.data(withJSONObject: self.group.jsonObject, options: [])
            try data.write(to: filePath)
        } catch {
            print(error)
        }
    }
    
    public static let firstNameLabel = "Firstname"
    public static let lastNameLabel = "Lastname"
    public static let emailLabel = "Email"
    public static let passwordLabel = "Password"
    public static let groupsLabel = "Groups"
}
