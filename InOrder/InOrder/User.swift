//
//  User.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class User {//needs explicit access control
    var firstName: String
    var lastName: String
    var displayName: String {
        return "\(firstName) \(lastName)"
    }
    var email: String
    var password: String
    var groups: [Group]
    
    init(firstName: String, lastName: String, email: String, password: String, groups: [Group]) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.groups = groups
    }
    
    public static let firstNameLabel = "Firstname"
    public static let lastNameLabel = "Lastname"
    public static let emailLabel = "Email"
    public static let passwordLabel = "Password"
    public static let groupsLabel = "Groups"
}
