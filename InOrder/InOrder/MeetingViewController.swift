//
//  MeetingViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class MeetingViewController: UIViewController, SillyDelegate {
    
    func printFromModal(_ string: String) {
        print(string)
    }

    var agenda: Agenda!
    var newNotes: MeetingNotes!
    
    override func loadView() {
        super.loadView()
        
        //navigationItem.hidesBackButton = true  I don't want to implement this until I'm absolutely certain I can escape with my Adjourn key.
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let modal = segue.destination as! NeverUseViewController
        modal.delegate = self
    }
}

protocol SillyDelegate {
    func printFromModal(_ string: String)
}
