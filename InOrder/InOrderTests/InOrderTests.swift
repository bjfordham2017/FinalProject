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
}
