//
//  FirstViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 11/20/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let rootRef = FIRDatabase.database().reference()
    
    var check = false
    
    @IBOutlet var userName: UITextField!

    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainTabBarController" {
            var src = segue.destination as! mainTabBarController
            src.userName = userName.text!
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "mainTabBarController" {
            
            if check {
                return true
            }
            return false

        }
        if identifier == "CreateAccountViewController" {
            return true
        }
        
        return false
    }

    @IBAction func LogIn(_ sender: Any) {
        
        if (userName.text?.isEmpty)! || (password.text?.isEmpty)! {
            return
        }
        
        let log = rootRef.child("UserName")
        log.observe(.value, with: { (snapshot) in
            
            if snapshot.hasChild(self.userName.text!) {
                
                let correctPassword : String!
                correctPassword = snapshot.childSnapshot(forPath: self.userName.text!).childSnapshot(forPath: "Password").value as! String!

                if correctPassword == self.password.text {
                    print("That is the correct password")
                    
                    
                    mainInstance.name = self.userName.text!
                    mainInstance.friendRequestCheck = true
                    
                    mainInstance.getFriendRequestList()
                    
                    self.check = true
                    self.performSegue(withIdentifier: "mainTabBarController", sender: self)
                    
                } else {
                    print("That is the incorrect password")
                }
               
            }
            
        })
        
    }

}

