//
//  MembersViewController.swift
//  InOrder
//
//  Created by Brent Fordham on 10/10/17.
//  Copyright © 2017 Brent Fordham. All rights reserved.
//

import Foundation
import UIKit

class MembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var memberTable: UITableView!
    @IBOutlet var inviteButton: UIButton!
    
    var group: Group!
    var members: [Member]!
    
    override func loadView() {
        super.loadView()
        
        self.members = []
        if let membership = group.members {
            for (_, value) in membership {
                self.members.append(value)
            }
            memberTable.reloadData()
        }
        
        inviteButton.layer.cornerRadius = 7
        inviteButton.layer.borderWidth = 1
        inviteButton.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        let member = members[indexPath.row]
        
        cell.textLabel?.text = member.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "memberDetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "memberDetailSegue":
            if let row = memberTable.indexPathForSelectedRow?.row {
                let detailView = segue.destination as! MemberDetailViewController
                detailView.member = self.members[row]
            }
        case "newInviteSegue":
            let newInviteView = segue.destination as! NewInviteViewController
            newInviteView.groupSendingInvite = self.group
        default:
            print("Unexpected Segue Identifier")
        }
    }
}
