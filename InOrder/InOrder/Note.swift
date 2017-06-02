//
//  Note.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class Note {
    var name: String
    var note: String
    
    init(name: String, note: String) {
        self.name = name
        self.note = note
    }
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        output[Note.nameLabel] = self.name
        output[Note.noteLabel] = self.note
        return output
    }
    
    convenience init?(jsonDictionary: [String:Any]) {
        guard let name = jsonDictionary[Note.nameLabel] as? String,
        let note = jsonDictionary[Note.noteLabel] as? String
            else {
                return nil
        }
        self.init(name: name, note: note)
    }
    
    public static let nameLabel = "Name"
    public static let noteLabel = "Note"
}

extension Note: Equatable {
    public static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.name == rhs.name && lhs.note == rhs.note
    }
}
