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
    
    @IBOutlet var groupsTable: UITableView!
    
    var user: User!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.groupDirectory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = user.groupDirectory[indexPath.row]
        cell.textLabel?.text = group.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "groupSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        groupsTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "groupSegue":
            if let row = groupsTable.indexPathForSelectedRow?.row {
                let directoryEntry = user.groupDirectory[row]
                let group = Group(fromID: directoryEntry.id)
                let groupView = segue.destination as! ViewController
                groupView.group = group
                groupView.groupRef = directoryEntry
                groupView.user = self.user
            }
        case "createGroupSegue":
            let newGroupScene = segue.destination as! CreateGroupViewController
            newGroupScene.user = self.user
            newGroupScene.newGroup = Group()
        default:
            print("Unexpected Segue Identifier")
        }
    }
    
}
