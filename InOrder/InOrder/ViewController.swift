//
//  ViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 6/2/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var group: Group!
    
    @IBOutlet var groupName: UITextField!
    @IBOutlet var groupDescription: UITextField!
    
    override func loadView() {
        super.loadView()
        
        groupName.text = group.name
        groupDescription.text = group.description
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

