//
//  AgendaItem.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class AgendaItem {
    enum ItemStatus {
        case passed
        case failed
        case tabled
    }
    
    var name: String
    var description: String
    
    var notes: [Note]
    var amendments: [Note]//These should never have been optionals.  They can just be empty arrays
    
    var votesFor: Int?
    var votesAgainst: Int?
    var abstentions: Int?
    
    var status: ItemStatus?

    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.notes = [Note]()
        self.amendments = [Note]()
    }
    
    internal init(name: String, description: String, notes: [Note]?, amendments: [Note]?, votesFor: Int?, votesAgainst: Int?, abstentions: Int?, status: ItemStatus?){
        self.name = name
        self.description = description
        
        if let initnotes = notes {
            self.notes = initnotes
        } else {
            self.notes = [Note]()
        }
        if let initamendments = amendments {
            self.amendments = initamendments
        } else {
            self.amendments = [Note]()
        }
        if let initVotesFor = votesFor {
            self.votesFor = initVotesFor
        }
        if let initVotesAgainst = votesAgainst {
            self.votesAgainst = initVotesAgainst
        }
        if let initAbstentions = abstentions {
            self.abstentions = initAbstentions
        }
        if let initStatus = status {
            self.status = initStatus
        }
    }
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()
        output[AgendaItem.nameLabel] = self.name
        output[AgendaItem.descriptionLbel] = self.description
        
        if self.notes.isEmpty == false {
            let notesArray = self.notes.map({element in
            return element.jsonObject
            })
            output[AgendaItem.notesLabel] = notesArray
        }
        if self.amendments.isEmpty == false {
            let amendmentsArray = self.amendments.map({element in
                return element.jsonObject
            })
            output[AgendaItem.amendmentsLabel] = amendmentsArray
        }
        if let outVotesFor = self.votesFor {
            output[AgendaItem.votesForLabel] = outVotesFor
        }
        if let outVotesAgainst = self.votesAgainst {
            output[AgendaItem.votesAgainstLabel] = outVotesAgainst
        }
        if let outAbstentions = self.abstentions {
            output[AgendaItem.abstentionsLabel] = outAbstentions
        }
        if let outStatus = self.status {
            output[AgendaItem.statusLabel] = outStatus
        }
        return output
    }
    
    convenience init?(jsonDictionary: [String:Any]) {
        guard let name = jsonDictionary[AgendaItem.nameLabel] as? String,
        let description = jsonDictionary[AgendaItem.descriptionLbel] as? String
            else {
                return nil
        }
        
        var notes: [Note]? {
        if let notesJSON = jsonDictionary[AgendaItem.notesLabel] as? [[String:Any]] {
            return notesJSON.map({noteDictionary in
                return (Note(jsonDictionary: noteDictionary))!})
        } else {
            return nil
            }
        }
        
        var amendments: [Note]? {
            if let amendmentsJSON = jsonDictionary[AgendaItem.amendmentsLabel] as? [[String:Any]] {
                return amendmentsJSON.map({amendmentDictionary in
                    return (Note(jsonDictionary: amendmentDictionary))!})
            } else {
                return nil
            }
        }

        
        let votesFor = jsonDictionary[AgendaItem.votesForLabel] as? Int
        let votesAgainst = jsonDictionary[AgendaItem.votesAgainstLabel] as? Int
        let abstentions = jsonDictionary[AgendaItem.abstentionsLabel] as? Int
        let status = jsonDictionary[AgendaItem.statusLabel] as? ItemStatus
        
        self.init(name: name, description: description, notes: notes, amendments: amendments, votesFor: votesFor, votesAgainst: votesAgainst, abstentions: abstentions, status: status)
    }
    
    public static let nameLabel = "Name"
    public static let descriptionLbel = "Description"
    public static let notesLabel = "Notes"
    public static let amendmentsLabel = "Amendments"
    public static let votesForLabel = "Votesfor"
    public static let votesAgainstLabel = "Votesagainst"
    public static let abstentionsLabel = "Abstentions"
    public static let statusLabel = "Status"
}
