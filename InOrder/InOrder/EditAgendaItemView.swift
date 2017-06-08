//
//  EditAgendaItemView.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class EditAgenaItemViewController: UIViewController {
    var item: AgendaItem!
    
    @IBOutlet var itemDescription: UITextView!
    @IBOutlet var name: UITextField!
    
    override func loadView() {
        super.loadView()
        
        name.text = item.name
        itemDescription.text = item.description
        
    }
}
