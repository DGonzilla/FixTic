//
//  StudentMainViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 7/14/18.
//  Copyright © 2018 David Adrien Gonzalez. All rights reserved.
// 

import UIKit
import Firebase
import FirebaseFirestore

class StudentMainViewController: UIViewController {
    
    // Wiring for objects
    @IBOutlet weak var userFirstNameLabel: UILabel!
    
    @IBAction func checkStatusButton(_ sender: UIButton) {
    }
    
    @IBAction func submitFixTicButton(_ sender: UIButton) {
        
    }
    
    
    var userEmail = ""
    var userFirstName = ""
    var userLastName = ""
    var userType = ""
    
    
    override func viewDidLoad() {
        
        // Calls function to pull user's info before view loads
        fetchUserInfo()
        
        super.viewDidLoad()
        
        print("Student Main has loaded")
        print(userFirstName, userLastName, userEmail, userType)
        
    }
    
    
    
    
    // Function that will fetch data on user whose email was used to log in
    func fetchUserInfo(){
        // Declares database
        let db = Firestore.firestore()
        // Pulling user information by email address used to log in
        db.collection("users").whereField("Email", isEqualTo: userEmail).getDocuments {
            (snapshot, error) in if error != nil {
                // prints error if issue arises
                print(error!)
            } else {
                
                for document in (snapshot?.documents)! {
                    // Queries user's first name
                    if let userFirstName = document.data()["First Name"] as? String{
                        // Queries user's last name
                        if let userLastName = document.data()["Last Name"] as? String{
                            // Queries user's account type
                            if let userType = document.data()["Account Type"] as? String{
                                
                                // Sets userFirstNameLabel to the user's first name
                                self.userFirstNameLabel.text = userFirstName
                                print(userFirstName, userLastName, userType)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    // Sends SubmitTicketViewController the user's information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Button pressed to transition to Submit Ticket")
        fetchUserInfo()

        
        
        if segue.identifier == "StudentSubmitTicketViewSegue" {
            
            
            let submitTicketViewController = segue.destination as! SubmitTicketViewController
            submitTicketViewController.userEmail = userEmail
            submitTicketViewController.userFirstName = userFirstName
            submitTicketViewController.userLastName = userLastName
            submitTicketViewController.userType = userType
        }
        
        if segue.identifier == "StudentCheckStatusSegue" {
            
            
            let checkStatusViewController = segue.destination as! CheckStatusViewController
            checkStatusViewController.userEmail = userEmail
            checkStatusViewController.userFirstName = userFirstName
            checkStatusViewController.userLastName = userLastName
            checkStatusViewController.userType = userType
        }
        
    }
    
    
    
    
    
}
