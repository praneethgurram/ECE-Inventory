//
//  SearchUsersViewController.swift
//  Demo
//
//  Created by Ning Li on 2/11/16.
//  Copyright © 2016 ningli. All rights reserved.
//

import UIKit

class SearchUsersViewController: UIViewController {
    
    // hardcoded user data
    var users: [User] = [
            User(),
            User(id: "ningli", name: "Ning Li", email: "ningli@vt.edu",
                items: [Item(name: "Windows Server", barcode: "0123456789", location: "Virginia Tech", owner: "Ning Li"),
                        Item(name: "Projector", barcode: "0123456789", location: "Virginia Tech", owner: "Ning Li"),
                        Item(name: "Amazon Kindle", barcode: "0123456789", location: "Virginia Tech", owner: "Ning Li")
                       ]
                )
    ]
    
    var selectedUser: User?

    @IBOutlet weak var userIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    @IBAction func cancelFromUserDetailsViewToSearchUsersView(segue: UIStoryboardSegue) {
    
    }
    
    @IBAction func searchForUsers() {
        var found: Bool = false
        for user in users {
            if user.id == userIDTextField.text {
                found = true
                self.selectedUser = user
                performSegueWithIdentifier("UserSelected", sender: nil)
            }
        }
        if !found {
            let alert = UIAlertController(title: "Error", message: "User not found.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "UserSelected") {
            let navView = segue.destinationViewController as! UINavigationController
            let userDetailsView = navView.viewControllers.first as! UserDetailsViewController
            userDetailsView.user = self.selectedUser
        }
    }

}
