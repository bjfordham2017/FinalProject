//
//  NeverUseViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import  UIKit

class NeverUseViewController: UIViewController {
    
    var delegate: SillyDelegate!
    
    @IBAction func back(_ sender: UIButton) {
        let sillyString = "This string is silly"
        delegate.printFromModal(sillyString)
        dismiss(animated: true, completion: nil)
        
    }
    
}
