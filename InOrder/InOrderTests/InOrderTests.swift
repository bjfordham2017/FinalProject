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
        let newAgendaItem = AgendaItem(name: "Resolution", description: "The resolution we will now consider")
        newAgendaItem.notes.append(newNote)
        let JSON = newAgendaItem.jsonObject
        let fromJSON = AgendaItem(jsonDictionary: JSON)
        let noteFromJSON = fromJSON!.notes[0]
        print("\(String(describing: fromJSON?.jsonObject))")
        XCTAssertEqual(newAgendaItem.name, fromJSON!.name)
        XCTAssertEqual(newAgendaItem.description, fromJSON!.description)
        XCTAssertEqual(newAgendaItem.notes, fromJSON!.notes)
        XCTAssertEqual(newNote.name, noteFromJSON.name)
        XCTAssertEqual(newNote.note, noteFromJSON.note)
    }
    
    func testAgendaJSONwhileEmpty() {
        let newAgenda = Agenda()
        let agendaJSON = newAgenda.jsonObject
        let agendaFromJSON = Agenda(jsonDictionary: agendaJSON)
        XCTAssertTrue(agendaFromJSON.agenda.isEmpty)
    }
    
    func testAgendaJSON() {
        let newAgendaItem = AgendaItem(name: "Resolution", description: "The resolution we will now consider")
        let newAgenda = Agenda()
        newAgenda.agenda.append(newAgendaItem)
        let agendaJSON = newAgenda.jsonObject
        let agendaFromJSON = Agenda(jsonDictionary: agendaJSON)
        print("\(agendaFromJSON.jsonObject)")
        XCTAssertEqual(newAgenda.agenda[0].name, agendaFromJSON.agenda[0].name)
    }
    
    func testMeetingNotesJSON() {
        let newMeetingNotes = MeetingNotes(date: Date())
        let JSON = newMeetingNotes.jsonObject
        let notesFromJSON = MeetingNotes(jsonDictionary: JSON)
        XCTAssertEqual(newMeetingNotes.date, notesFromJSON?.date)
    }
    
    func testGroupJSON() {
        let newGroup = Group()
        let newMeetingNotes = MeetingNotes(date: Date())
        let newAgendaItem = AgendaItem(name: "Resolution", description: "The resolution we will now consider")
        let newNote = Note(name: "New Note", note: "Remember to make sure JSON works")
        newAgendaItem.notes.append(newNote)
        let newAgenda = Agenda()
        newAgenda.agenda.append(newAgendaItem)
        newGroup.meetingHistory.history.append(newMeetingNotes)
        newGroup.upcomingAgenda = newAgenda
        
        let JSON = newGroup.jsonObject
        let groupfromJSON = Group(jsonDictionary: JSON)
        print("\(JSON)")
        XCTAssertEqual(newGroup.meetingHistory.history[0].date, groupfromJSON.meetingHistory.history[0].date)
        XCTAssertEqual(newGroup.upcomingAgenda.agenda[0].notes[0].note, groupfromJSON.upcomingAgenda.agenda[0].notes[0].note)
    }
}
