//
//  MotionDelegate.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

protocol MotionDelegate {
    func tally(votefor: Int, voteagainst: Int, abstension: Int)
    func passFail(motion: Motions, result: Bool)
    func recordNote(name: String, description: String, general: Bool)
    func recordAmendment(name: String, description: String)
}
