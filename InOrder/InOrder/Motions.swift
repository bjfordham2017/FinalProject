//
//  Motions.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

enum Motions: CustomStringConvertible {
    case adjourn
    case recess
    case table
    case amend
    case previousQuestion
    
    var description: String {
        switch self {
        case .adjourn:
            return "Adjourn"
        case .amend:
            return "Amend"
        case .recess:
            return "Recess"
        case .table:
            return "Table"
        case .previousQuestion:
            return "Close Debate"
        }
    }
}
