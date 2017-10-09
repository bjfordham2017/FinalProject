//
//  MotionDelegate.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

protocol MotionDelegate {
    func passFail(motion: Motions, result: Bool)
    func recordNote(name: String, description: String, general: Bool)
    func cancelMotion()
}

protocol MainMotionDelegate: MotionDelegate {
    func tally(votefor: Int, voteagainst: Int, abstension: Int)
    func recordAmendment(name: String, description: String)
}
