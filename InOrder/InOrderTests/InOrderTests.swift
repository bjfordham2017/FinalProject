//
//  InOrderTests.swift
//  InOrderTests
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import XCTest
@testable import InOrder

class InOrderTests: XCTestCase {
    func testNoteJSON() {
        let newNote = Note(name: "New Note", note: "Remember to make sure JSON works")
        let JSON = newNote.jsonObject
        let fromJSON = Note(jsonDictionary: JSON)
        XCTAssertEqual(newNote.name, fromJSON!.name)
        XCTAssertEqual(newNote.note, fromJSON!.note)
    }
    
    func testAgendaItemJSONwoNotes() {
        let newAgendaItem = AgendaItem(name: "Resolution", description: "The resolution we will now consider")
        let JSON = newAgendaItem.jsonObject
        let fromJSON = AgendaItem(jsonDictionary: JSON)
        XCTAssertEqual(newAgendaItem.name, fromJSON!.name)
        XCTAssertEqual(newAgendaItem.description, fromJSON!.description)
    }
    
    func testAgendaItemJSONwNotes() {
        let newNote = Note(name: "New Note", note: "Remember to make sure JSON works")
        var newAgendaItem = AgendaItem(name: "Resolution", description: "The resolution we will now consider")
        newAgendaItem.notes.append(newNote)
        let JSON = newAgendaItem.jsonObject
        let fromJSON = AgendaItem(jsonDictionary: JSON)
        let noteFromJSON = fromJSON!.notes[0]
        XCTAssertEqual(newAgendaItem.name, fromJSON!.name)
        XCTAssertEqual(newAgendaItem.description, fromJSON!.description)
        XCTAssertEqual(newAgendaItem.notes, fromJSON!.notes)
        XCTAssertEqual(newNote.name, noteFromJSON.name)
        XCTAssertEqual(newNote.note, noteFromJSON.note)
    }
}
