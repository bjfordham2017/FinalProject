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
    var groupDirectory: [GroupDirectoryEntry] = []
    let filePath: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("SecondPresentationUser.json")
    }()
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        let directoryJSON = self.groupDirectory.map({item in
            return item.jsonObject
        })
        output[User.groupDirectoryLabel] = directoryJSON
        return output
    }
    
    init() {
        if let data = try? Data(contentsOf: filePath),
            let JSON = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonDictionary = JSON as? [String:Any],
            let directoryJSON = jsonDictionary[User.groupDirectoryLabel] as? [[String:Any]] {
            let directoryOptionals = directoryJSON.map({element in
                return GroupDirectoryEntry(jsonObject: element)})
            for item in directoryOptionals {
                if let directoryEntry = item {
                    self.groupDirectory.append(directoryEntry)
                }
            }
        }
    }
    
    func save() {
        do {
            let data = try JSONSerialization.data(withJSONObject: self.jsonObject, options: [])
            try data.write(to: filePath)
        } catch {
            print(error)
        }
    }
    
    public static let firstNameLabel = "Firstname"
    public static let lastNameLabel = "Lastname"
    public static let emailLabel = "Email"
    public static let passwordLabel = "Password"
    public static let groupDirectoryLabel = "GroupDirectory"
}

class GroupDirectoryEntry {
    var name: String
    let id: UUID
    
    init(name: String, id: UUID) {
        self.name = name
        self.id = id
    }
    
    init?(jsonObject: [String:Any]){
        guard let name = jsonObject[GroupDirectoryEntry.nameLabel] as? String,
            let idString = jsonObject[GroupDirectoryEntry.idLabel] as? String,
            let id = UUID(uuidString: idString)
            else {
                return nil
        }
        
        self.name = name
        self.id = id
    }
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        output[GroupDirectoryEntry.nameLabel] = name
        output[GroupDirectoryEntry.idLabel] = id.uuidString
        return output
    }
    
    public static let nameLabel = "Name"
    public static let idLabel = "ID"
}

