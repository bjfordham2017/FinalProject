//
//  EditAgendaItemView.swift
//  InOrder
//
//  Created by Brent Fordham on 6/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class EditAgenaItemViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var item: AgendaItem!
    
    @IBOutlet var itemDescription: UITextView!
    @IBOutlet var name: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    override func loadView() {
        super.loadView()
        
        name.text = item.name
        itemDescription.text = item.description
        
        saveButton.layer.cornerRadius = 7
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.lightGray.cgColor

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        print("Editing ended")
        
        item.name = name.text ?? "Unnamed Item"
        item.description = itemDescription.text
    }
    
    
    @IBAction func tapToEndEditing(_ sender: Any) {
        view.endEditing(true)
        print("Editing ended")
        
        item.name = name.text ?? "Unnamed Item"
        item.description = itemDescription.text
    }

    @IBAction func saveChagnes(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
