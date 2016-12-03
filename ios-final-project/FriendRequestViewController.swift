//
//  FriendRequestViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/29/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class FriendRequestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let currentUser = FIRDatabase.database().reference().child("UserName").child(mainInstance.name)
    let allUsers = FIRDatabase.database().reference().child("UserName")
    var friendRequestList = [String]()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        friendRequestList = mainInstance.friendRequestList
    
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.friendRequestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.friendRequestList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let acceptAction = UITableViewRowAction.init(style: .normal, title: "Accept", handler: {(rowAction, indexPath) in
            print("Accept action has been pressed")
            self.addFriend(indexPath: indexPath)
        
        })
        
        acceptAction.backgroundColor = UIColor.green
        
        let notNowAction = UITableViewRowAction.init(style: .default, title: "Not now", handler: {(rowAction, indexPath) in
            print("Not now action has been pressed")
            
            self.declineFriend(indexPath: indexPath)
            
        })
        
        return [notNowAction, acceptAction]
    }
    
    func addFriend(indexPath: IndexPath) {
        
        print(String(self.friendRequestList.count))
        print(String(self.tableView.numberOfRows(inSection: 0)))
        
        self.tableView.beginUpdates()
        let addFriend = self.friendRequestList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        self.tableView.endUpdates()

        self.currentUser.child("FriendRequest").child(addFriend).removeValue()
        self.currentUser.child("Friends").child(addFriend).setValue(0)
        self.allUsers.child(addFriend).child("Friends").child(self.currentUser.key).setValue(0)
        
        print(String(self.friendRequestList.count))
        print(String(self.tableView.numberOfRows(inSection: 0)))
        
        }
    
    func declineFriend(indexPath: IndexPath) {
        
        print(String(self.friendRequestList.count))
        print(String(self.tableView.numberOfRows(inSection: 0)))

        
        self.tableView.beginUpdates()
        let removedFriend = self.friendRequestList.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        self.tableView.endUpdates()
                
        self.currentUser.child("FriendRequest").child(removedFriend).removeValue()
        
        print(String(self.friendRequestList.count))
        print(String(self.tableView.numberOfRows(inSection: 0)))

    }
    

    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
