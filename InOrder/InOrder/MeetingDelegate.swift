//
//  MeetingDelegate.swift
//  InOrder
//
//  Created by Brent Fordham on 6/11/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation

protocol MeetingDelegate {
    func recordMeeting(newMeeting: MeetingNotes?, nextAgenda: Agenda)
}

protocol MeetingWalkthroughDelegate {
    func transferMeetingInfo(newMeeting: MeetingNotes?, nextAgenda: Agenda)
}
