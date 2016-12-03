//
//  global.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/29/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import Foundation
import Firebase

class Main {
    
    
    var friendRequestList = [String]()
    var name:String
    var friendRequestCheck : Bool
    init(name:String, friendRequestCheck: Bool) {
        self.name = name
        self.friendRequestCheck = friendRequestCheck
        
    }
    func getFriendRequestList() {
        
        if friendRequestCheck {
        let currentUser = FIRDatabase.database().reference().child("UserName").child(name)
        friendRequestList.removeAll()
        
        let requestList = currentUser.child("FriendRequest")
        
        requestList.observe(.value, with: {(snapshot) in
            
            for friend in snapshot.children {
                let snapString = String(describing: friend)
                let parsedString = self.parseUserName(username: snapString)
                self.friendRequestList.append(parsedString)
                print(parsedString)
            }
        })
        }
        friendRequestCheck = false
    }

    func parseUserName(username: String) -> String {
        var user = ""
        let currentUserName = username.characters
    
        var checkParse = false
        for character in currentUserName {
            if checkParse {
                if character == ")" {
                    break
                }
                user += character.description
            }
            if character == "(" {
                checkParse = true
            }
        }
        return user
    }
}

var mainInstance = Main(name: "My Global Class", friendRequestCheck: true)
