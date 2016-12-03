//
//  NewEventViewController.swift
//  ios-final-project
//
//  Created by Michael Ma on 12/1/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {

    //variables
    @IBOutlet var eventTitle: UITextField!
    @IBOutlet var eventDetails: UITextView!

    @IBOutlet var eventPlace: UITextField!
    
    @IBOutlet var eventDateAndTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
