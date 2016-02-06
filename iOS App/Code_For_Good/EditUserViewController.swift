//
//  EditUserViewController.swift
//  Code_For_Good
//
//  Created by Kristie Harvick on 2/6/16.
//  Copyright © 2016 team3. All rights reserved.
//

import UIKit
import Firebase

class EditUserViewController: UIViewController {
    
    var ref = Firebase(url:"https://incandescent-inferno-8240.firebaseio.com")
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func saveTouched(sender: AnyObject) {
        if (firstName.text != "" && lastName.text != "" && email.text != "" && password.text != "") {
            
            var usersRef = ref.childByAppendingPath("users")
            
            usersRef.childByAutoId().setValue([
                "firstName": firstName.text!,
                "lastName": lastName.text!,
                "email": email.text!,
                "password": password.text!
                ])
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func screenTouched(sender: AnyObject) {
        view.endEditing(true)
    }
}