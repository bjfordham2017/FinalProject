//
//  AgendaItem.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class AgendaItem {
    enum ItemStatus: CustomStringConvertible {
        case passed
        case failed
        case tabled
        case inProgress
        
        var description: String {
            switch self {
            case .passed:
                return "Passed"
            case .failed:
                return "Failed"
            case .tabled:
                return "Tabled"
            case .inProgress:
                return "In Progress"
            }
        }
    }
    
    var name: String
    var description: String
    
    var notes: [Note]
    var amendments: [Note]//These should never have been optionals.  They can just be empty arrays
    
    var votesFor: Int = 0
    var votesAgainst: Int = 0
    var abstentions: Int = 0
    
    var isTabled: Bool = false
    
    var status: ItemStatus {
        if isTabled {
            return .tabled
        } else {
            if votesFor == 0 && votesAgainst == 0 && abstentions == 0 {
                return .inProgress
            } else if votesFor > votesAgainst {
                return .passed
            } else if votesFor < votesAgainst {
                return .failed
            } else {
                return .failed
            }
        }
    }

    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.notes = [Note]()
        self.amendments = [Note]()
    }
    
    internal init(name: String, description: String, notes: [Note]?, amendments: [Note]?, votesFor: Int?, votesAgainst: Int?, abstentions: Int?, isTabled: Bool){
        self.name = name
        self.description = description
        self.isTabled = isTabled
        
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
        
        output[AgendaItem.votesForLabel] = self.votesFor
        
        output[AgendaItem.votesAgainstLabel] = self.votesAgainst
            
        output[AgendaItem.abstentionsLabel] = self.abstentions
        
        output[AgendaItem.isTabledLabel] = self.isTabled
        
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

        var votesFor: Int? {
            if let jsonVotesFor = jsonDictionary[AgendaItem.votesForLabel] as? Int {
                return jsonVotesFor
            } else {
                return nil
            }
        }
        
        var votesAgainst: Int? {
            if let jsonVotesAgainst = jsonDictionary[AgendaItem.votesAgainstLabel] as? Int {
                return jsonVotesAgainst
            } else {
                return nil
            }
        }
        
        var abstentions: Int? {
            if let jsonAbstentions = jsonDictionary[AgendaItem.abstentionsLabel] as? Int {
                return jsonAbstentions
            } else {
                return nil
            }
        }
        
        let isTabled = jsonDictionary[AgendaItem.isTabledLabel] as? Bool
        
        self.init(name: name, description: description, notes: notes, amendments: amendments, votesFor: votesFor, votesAgainst: votesAgainst, abstentions: abstentions, isTabled: isTabled!)
    }
    
    func inputVoteTally(votesFor: Int, votesAgainst: Int, abstained: Int) {
        self.votesFor += votesFor
        self.votesAgainst += votesAgainst
        self.abstentions += abstained
    }
    
    func table() {
        self.isTabled = true
    }
    
    func untable() {
        self.isTabled = false
    }
    
    public static let nameLabel = "Name"
    public static let descriptionLbel = "Description"
    public static let notesLabel = "Notes"
    public static let amendmentsLabel = "Amendments"
    public static let votesForLabel = "Votesfor"
    public static let votesAgainstLabel = "Votesagainst"
    public static let abstentionsLabel = "Abstentions"
    public static let isTabledLabel = "Istabled"
}
