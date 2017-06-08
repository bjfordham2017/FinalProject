//
//  Agenda.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

class Agenda {
    var agenda = [AgendaItem]()
    
    var jsonObject: [String:Any] {
        var output = [String:Any]()

        let agendaItemJSON = self.agenda.map({member in
            return member.jsonObject})
        output[Agenda.agendaLabel] = agendaItemJSON

        return output
    }
    
    init() {
        self.agenda = [AgendaItem]()
    }
    
    internal init (agenda: [AgendaItem]) {
        self.agenda = agenda
    }
    
    convenience init(jsonDictionary: [String:Any]) {
        if let agenda = jsonDictionary[Agenda.agendaLabel] as? [[String:Any]] {
            let agendaItems = agenda.map({member in
            return AgendaItem(jsonDictionary: member)!})
            self.init(agenda: agendaItems)
        } else {
            self.init()
        }
    }
    
    func arrangeAgenda(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = agenda[fromIndex]
        agenda.remove(at: fromIndex)
        agenda.insert(movedItem, at: toIndex)
    }

    
    public static let agendaLabel = "Agenda"
}
