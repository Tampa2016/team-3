//
//  LoginViewController.swift
//  Code_For_Good
//
//  Created by Nicholas Miller on 2/5/16.
//  Copyright © 2016 team3. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref = Firebase(url:"https://incandescent-inferno-8240.firebaseio.com")
    
    var isMatch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.frame = CGRectMake(20, 470, 150, 40)
        loginButton.readPermissions = ["email", "user_friends"]
        self.view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(sender: AnyObject) {
        if (usernameTextField.text != "" && passwordTextField.text != "") {
            var person = ["password": passwordTextField.text!]
            var usersRef = ref.childByAppendingPath("users")
//            var users = [usernameTextField.text!: person]
//            usersRef.setValue(users)
            
            usersRef.childByAutoId().setValue([
                "username": usernameTextField.text!,
                "password": passwordTextField.text!
            ])
            
        }
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "Get", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Failed to get the request")
        }
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User logged in")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "LoginToApp") {
            
            var usersRef = ref.childByAppendingPath("users")
            
            usersRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
                if let people = snapshot.children {
                    
                    for (var i = 0; i < Int(snapshot.childrenCount); i++) {
                        
                        let person = people.nextObject() as! FDataSnapshot
                        
                        let user = person.value
                        
                        print("\(user["username"])")
                        print("\(user["password"])")
                        
                        if (String(user["username"]) == self.usernameTextField.text! && String(user["password"]) == self.passwordTextField.text!) {
                            self.isMatch = true
                        }

                        
                    }
                    
                }
            })
        }
        
        if (isMatch) {
            return true
        }
        else {
            return false
        }
    }

}
