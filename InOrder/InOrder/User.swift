//
//  User.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class User {//needs explicit access control
    
    let name: String
    let email: String
    let id: UUID
    var groupDirectory: [GroupDirectoryEntry] = []
    var readOnlyGroupDirectory: [GroupDirectoryEntry] = []
    let filePath: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("thirdNewUser.json")
    }()
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        let directoryJSON = self.groupDirectory.map({item in
            return item.jsonObject
        })
        let readOnlyDirectoryJSON = self.readOnlyGroupDirectory.map({item in
            return item.jsonObject
        })
        output[User.groupDirectoryLabel] = directoryJSON
        output[User.readOnlyGroupDirectoryLabel] = readOnlyDirectoryJSON
        output[User.nameLabel] = self.name
        output[User.emailLabel] = self.email
        output[User.idLabel] = self.id.uuidString
        
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
        self.name = "New User"
        self.email = "noemail@void.com"
        self.id = UUID()
    }
    
    internal init (name: String, email: String, id: UUID, groupDirectory: [GroupDirectoryEntry], readOnlyGroupDirectory: [GroupDirectoryEntry]) {
        self.name = name
        self.email = email
        self.id = id
        self.groupDirectory = groupDirectory
        self.readOnlyGroupDirectory = readOnlyGroupDirectory
    }
    
    convenience init? (jsonOjbect: [String:Any]) {
        guard let name = jsonOjbect[User.nameLabel] as? String,
        let email = jsonOjbect[User.emailLabel] as? String,
        let idString = jsonOjbect[User.idLabel] as? String,
            let id = UUID(uuidString: idString) else {
                return nil
        }
        
        var groupDirectory: [GroupDirectoryEntry] {
            var output = [GroupDirectoryEntry]()
            if let directoryJSON = jsonOjbect[User.groupDirectoryLabel] as? [[String:Any]] {
                let directoryOptionals = directoryJSON.map({element in
                    return GroupDirectoryEntry(jsonObject: element)
                })
                for item in directoryOptionals {
                    if let directoryEntry = item {
                        output.append(directoryEntry)
                    }
                }
            }
            return output
        }
        
        var readOnlyGroupDirectory: [GroupDirectoryEntry] {
            var output = [GroupDirectoryEntry]()
            if let directoryJSON = jsonOjbect[User.readOnlyGroupDirectoryLabel] as? [[String:Any]] {
                let directoryOptionals = directoryJSON.map({element in
                    return GroupDirectoryEntry(jsonObject: element)
                })
                for item in directoryOptionals {
                    if let directoryEntry = item {
                        output.append(directoryEntry)
                    }
                }
            }
            return output
        }
        
        self.init(name: name, email: email, id: id, groupDirectory: groupDirectory, readOnlyGroupDirectory: readOnlyGroupDirectory)
    }
    
    func save() {
        do {
            let data = try JSONSerialization.data(withJSONObject: self.jsonObject, options: [])
            try data.write(to: filePath)
        } catch {
            print(error)
        }
    }
    
    public static let nameLabel = "Name"
    public static let idLabel = "ID"
    public static let emailLabel = "Email"
    public static let passwordLabel = "Password"
    public static let groupDirectoryLabel = "GroupDirectory"
    public static let readOnlyGroupDirectoryLabel = "ReadOnlyGroupDirectory"
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

