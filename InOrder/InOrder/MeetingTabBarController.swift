//
//  MeetingTabBarController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/7/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import UIKit

class MeetingTabBarController: UITabBarController {
    
    var meetingWalkThroughDelegate: MeetingWalkthroughDelegate!
    
    override func viewDidLoad() {
        navigationItem.title = "Meeting In Progress"
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        meetingWalkThroughDelegate.cancel()
    }
    
    
}
