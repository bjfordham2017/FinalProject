//
//  User.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import Firebase

class InOrderUser {//needs explicit access control
    
    let name: String
    let email: String
    let id: String
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
        output[InOrderUser.groupDirectoryLabel] = directoryJSON
        output[InOrderUser.readOnlyGroupDirectoryLabel] = readOnlyDirectoryJSON
        output[InOrderUser.nameLabel] = self.name
        output[InOrderUser.emailLabel] = self.email
        output[InOrderUser.idLabel] = self.id
        
        return output
    }
    
    init (name: String, email: String, id: String, groupDirectory: [GroupDirectoryEntry]? = [], readOnlyGroupDirectory: [GroupDirectoryEntry]? = []) {
        self.name = name
        self.email = email
        self.id = id
        
        if let groupDirectoryInput = groupDirectory {
            self.groupDirectory = groupDirectoryInput
        }
        
        if let readOnlyGroupDirectoryInput = readOnlyGroupDirectory {
            self.readOnlyGroupDirectory = readOnlyGroupDirectoryInput
        }
        
    }
    
    convenience init? (jsonOjbect: [String:Any]) {
        guard let name = jsonOjbect[InOrderUser.nameLabel] as? String,
        let email = jsonOjbect[InOrderUser.emailLabel] as? String,
        let id = jsonOjbect[InOrderUser.idLabel] as? String
            else {
                return nil
        }
        
        var groupDirectory: [GroupDirectoryEntry] {
            var output = [GroupDirectoryEntry]()
            if let directoryJSON = jsonOjbect[InOrderUser.groupDirectoryLabel] as? [[String:Any]] {
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
            if let directoryJSON = jsonOjbect[InOrderUser.readOnlyGroupDirectoryLabel] as? [[String:Any]] {
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
    
    convenience init? (dataSnapshot: DataSnapshot) {
        guard let firebaseJSON = dataSnapshot.value as? [String:Any],
            let name = firebaseJSON[InOrderUser.nameLabel] as? String,
            let email = firebaseJSON[InOrderUser.emailLabel] as? String,
            let id = firebaseJSON[InOrderUser.idLabel] as? String
            else {
                return nil
        }
        
        var groupDirectory: [GroupDirectoryEntry] {
            var output = [GroupDirectoryEntry]()
            if let directoryJSON = firebaseJSON[InOrderUser.groupDirectoryLabel] as? [[String:Any]] {
                for item in directoryJSON {
                    if let entry = GroupDirectoryEntry(jsonObject: item) {
                        output.append(entry)
                    }
                }
            }
            return output
        }
        
        var readOnlyGroupDirectory: [GroupDirectoryEntry] {
            var output = [GroupDirectoryEntry]()
            if let directoryJSON = firebaseJSON[InOrderUser.readOnlyGroupDirectoryLabel] as? [[String:Any]] {
                for item in directoryJSON {
                    if let entry = GroupDirectoryEntry(jsonObject: item) {
                        output.append(entry)
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

