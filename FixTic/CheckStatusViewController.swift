//
//  CheckStatusViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 12/27/18.
//  Copyright © 2018 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore



class CheckStatusViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    
    
    
    @IBAction func returnToStudentMain(_ sender: UIButton) {
        
        performSegue(withIdentifier: "CheckStatusReturnToStudentMainViewSegue", sender: self)
        
    }
    
    
    
    
    
    
    // Declares variables to be used
    var userEmail = ""
    var userFirstName = ""
    var userLastName = ""
    var userType = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
    
    
    
    
    // Sends StudentMainViewController the user's information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CheckStatusReturnToStudentMainViewSegue" {
            
            
            let studentMainViewController = segue.destination as! StudentMainViewController
            studentMainViewController.userEmail = userEmail
            studentMainViewController.userFirstName = userFirstName
            studentMainViewController.userLastName = userLastName
            studentMainViewController.userType = userType
        }
    }
    
    
    
}

