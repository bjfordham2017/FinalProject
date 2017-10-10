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
    @IBOutlet var newGroupButton: UIButton!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGroupButton.layer.cornerRadius = 7
        newGroupButton.layer.borderWidth = 1
        newGroupButton.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if user.groupDirectory.isEmpty {
                return "You are not managing any groups"
            } else {
                return "Groups you manage"
            }
        case 1:
            if user.readOnlyGroupDirectory.isEmpty {
                return "You are not following any groups"
            } else {
                return "Groups you follow"
            }
        default:
            fatalError("Unexpected section index")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return user.groupDirectory.count
        case 1:
            return user.readOnlyGroupDirectory.count
        default:
            fatalError("Unexpected section index")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        
        var group: GroupDirectoryEntry {
            switch indexPath.section {
            case 0:
                return user.groupDirectory[indexPath.row]
            case 1:
                return user.readOnlyGroupDirectory[indexPath.row]
            default:
                fatalError("Unexpected index path")
            }
        }
        
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
            if let indexPath = groupsTable.indexPathForSelectedRow {
                var directoryEntry: GroupDirectoryEntry {
                    switch indexPath.section {
                    case 0:
                        return user.groupDirectory[indexPath.row]
                    case 1:
                        return user.readOnlyGroupDirectory[indexPath.row]
                    default:
                        fatalError("Unexpected index path")
                    }
                }
                let group = Group(fromID: directoryEntry.id)
                var readOnly: Bool {
                    switch indexPath.section {
                    case 0:
                        return false
                    case 1:
                        return true
                    default:
                        fatalError("Unexpected index path")
                    }
                }
                let groupView = segue.destination as! ViewController
                groupView.group = group
                groupView.groupRef = directoryEntry
                groupView.user = self.user
                groupView.readOnly = readOnly
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
