//
//  LoginVC.swift
//  WF_Code_Challenge
//
//  Created by Jamal Jones on 9/22/16.
//  Copyright © 2016 Jamal Jones. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginVC: UIViewController {

    @IBOutlet weak var overlayView: UIView!
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var authenticateView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add border to background view
        self.backgroundView.layer.borderWidth = 3
        self.backgroundView.layer.borderColor = UIColor.black.cgColor
        
        //add border to login button
        self.loginButton.layer.borderWidth = 1
        self.loginButton.layer.borderColor = UIColor.white.cgColor
        
    }

    
    @IBAction func login(_ sender: AnyObject) {
        
        //hide login button
        self.loginButton.isHidden = true
        
        //show overlay view
        self.overlayView.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        
        //show authenticate view
        self.authenticateView.isHidden = false
        
        authenticateUser()
    }

    
    func authenticateUser() {
        //Create a authentication context
        let authenticationContext = LAContext()
        
        //Create error variable
        var error:NSError?
        
        //Message for Authentication Alert
        let reasonString = "Authentication Needed to Login"
        
        //Check if Touch ID is available
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, error) in
                if success {
                    //Touch ID worked
                    print("Authentication Successful")
                    self.performSegue(withIdentifier: "login", sender: nil)
                } else {
                    //Touch ID failed
                    print(error?.localizedDescription)
                    self.authenticateUser()
                }
            })
        } else {
            //Touch ID not availabel
            print(error?.localizedDescription)
            self.authenticateUser()
        }
    
    }
    
    
}
