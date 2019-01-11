//
//  TechMainViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 7/14/18.
//  Copyright © 2018 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class TechMainViewController: UIViewController {

    
    
    // Wires all view objects
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBAction func runReportButton(_ sender: UIButton) {
    }
    @IBAction func viewTicketsButton(_ sender: UIButton) {
    }
    
    
    var techUserEmail = ""
    var techUserFirstName = ""
    var techUserLastName = ""
    var userType = ""
    
    
    
    
    override func viewDidLoad() {
        
        fetchUserInfo()
        
        super.viewDidLoad()

    }
    

    
    
    
    // Function that will fetch data on user whose email was used to log in
    func fetchUserInfo(){
        // Declares database
        let db = Firestore.firestore()
        
        // Pulling user information by email address used to log in
        db.collection("users").whereField("Email", isEqualTo: techUserEmail).getDocuments {
            (snapshot, error) in if error != nil {
                // prints error if issue arises
                print(error!)
            } else {
                
                for document in (snapshot?.documents)! {
                    // Queries user's first name
                    if let userFirstNameFromDatabase = document.data()["First Name"] as? String{
                        // Queries user's last name
                        if let userLastNameFromDatabase = document.data()["Last Name"] as? String{
                            // Queries user's account type
                            if let userTypeFromDatabase = document.data()["Account Type"] as? String{
                                
                                // Sets userFirstNameLabel to the user's first name
                                self.userFirstNameLabel.text = userFirstNameFromDatabase
                                
                                // Declares variables from database
                                self.techUserFirstName = userFirstNameFromDatabase
                                self.techUserLastName = userLastNameFromDatabase
                                self.userType = userTypeFromDatabase
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    // Sends SubmitTicketViewController or CheckStatusViewController the user's information accordingly
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "TechRunReportSegue" {
            
            let runReportViewController = segue.destination as! RunReportViewController
            runReportViewController.techUserEmail = techUserEmail
            runReportViewController.techUserFirstName = techUserFirstName
            runReportViewController.techUserLastName = techUserLastName
            runReportViewController.userType = userType
        }
        
        if segue.identifier == "TechViewAllTicketsSegue" {


            let viewAllTicketsTechViewController = segue.destination as! ViewAllTicketsTechViewController
            viewAllTicketsTechViewController.techUserEmail = techUserEmail
            viewAllTicketsTechViewController.techUserFirstName = techUserFirstName
            viewAllTicketsTechViewController.techUserLastName = techUserLastName
            viewAllTicketsTechViewController.userType = userType
        }
    }
    
    
    
    
    
    
    
    
    
    
    

}
