//
//  StudentFixTicErrorViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 12/22/18.
//  Copyright © 2018 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore


class StudentFixTicErrorViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
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
        
        if segue.identifier == "ReturnBackToSubmitTicketFromErrorView" {
            
            
            let submitTicketViewController = segue.destination as! SubmitTicketViewController
            submitTicketViewController.userEmail = userEmail
            submitTicketViewController.userFirstName = userFirstName
            submitTicketViewController.userLastName = userLastName
            submitTicketViewController.userType = userType
        }
    }
    
    
    
    
    
    
    
    
}
