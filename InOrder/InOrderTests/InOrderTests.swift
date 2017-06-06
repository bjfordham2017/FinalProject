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
    
    func testAgendaItemStatusandMethods() {
        let passedAgendaItem = AgendaItem(name: "Passed", description: "Now it's off for the presidential veto")
        passedAgendaItem.inputVoteTally(votesFor: 5, votesAgainst: 3, abstained: 1)
        let failedAgendaItem = AgendaItem(name: "Failed", description: "Parliment don't play that!")
        failedAgendaItem.inputVoteTally(votesFor: 1, votesAgainst: 5, abstained: 3)
        let tabledAgendaItem = AgendaItem(name: "Tabled", description: "We'll talk about it next time")
        tabledAgendaItem.table()
        let failedByDefaulAgendaItem = AgendaItem(name: "Fails by default", description: "Everyone abstained")
        failedByDefaulAgendaItem.inputVoteTally(votesFor: 0, votesAgainst: 0, abstained: 9)
        XCTAssertEqual(passedAgendaItem.status, .passed)
        XCTAssertEqual(failedAgendaItem.status, .failed)
        XCTAssertEqual(tabledAgendaItem.status, .tabled)
        XCTAssertEqual(failedByDefaulAgendaItem.status, .failed)
    }
    
    func testAgendaItemJSONwVotesandStatus() {
        let passedAgendaItem = AgendaItem(name: "Passed", description: "Now it's off for the presidential veto")
        passedAgendaItem.inputVoteTally(votesFor: 5, votesAgainst: 3, abstained: 1)
        let JSON = passedAgendaItem.jsonObject
        let fromJSON = AgendaItem(jsonDictionary: JSON)
        XCTAssertEqual(passedAgendaItem.status, fromJSON?.status)
    }
    
    func testJSONtofromLocalStorage() {
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
        
        let validJSON = JSONSerialization.isValidJSONObject(JSON)
        XCTAssertTrue(validJSON)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: JSON, options: [])
        let filePath: URL = {
            let documentsDirectories =
                FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentDirectory = documentsDirectories.first!
            return documentDirectory.appendingPathComponent("test.json")
        }()
        
        let _ = try! jsonData.write(to: filePath)
        let returnData = try! Data(contentsOf: filePath, options: [])
        let returnObject = try! JSONSerialization.jsonObject(with: returnData, options: [])
        let returnJSON = returnObject as! [String:Any]
        
        let groupfromJSON = Group(jsonDictionary: returnJSON)
        print("\(filePath)")
        
        XCTAssertEqual(newGroup.meetingHistory.history[0].date, groupfromJSON.meetingHistory.history[0].date)
        XCTAssertEqual(newGroup.upcomingAgenda.agenda[0].notes[0].note, groupfromJSON.upcomingAgenda.agenda[0].notes[0].note)
    }
    
    func testUserInit() {
        let newGroup = Group()
        let newMeetingNotes = MeetingNotes(date: Date())
        let newAgendaItem = AgendaItem(name: "Resolution", description: "The resolution we will now consider")
        let newNote = Note(name: "New Note", note: "Remember to make sure JSON works")
        newAgendaItem.notes.append(newNote)
        let newAgenda = Agenda()
        newAgenda.agenda.append(newAgendaItem)
        newGroup.meetingHistory.history.append(newMeetingNotes)
        newGroup.upcomingAgenda = newAgenda

        let newUser = User()
        
        XCTAssertEqual(newGroup.meetingHistory.history[0].date, newUser.group.meetingHistory.history[0].date)
        XCTAssertEqual(newGroup.upcomingAgenda.agenda[0].notes[0].note, newUser.group.upcomingAgenda.agenda[0].notes[0].note)
    }
    
    
}
