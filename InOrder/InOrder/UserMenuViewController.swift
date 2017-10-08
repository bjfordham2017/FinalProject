//
//  UserMenuViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/8/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class UserMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var user: User!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        cell.textLabel?.text = user.group.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "groupSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "groupSegue":
            let groupView = segue.destination as! ViewController
            groupView.group = self.user.group
        default:
            print("Unexpected Segue Identifier")
        }
    }
    
}
