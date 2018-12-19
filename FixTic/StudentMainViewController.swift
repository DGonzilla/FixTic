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
    
    
    var userFirstName = ""
    var userEmail = ""
    var userLastName = ""
    var userType = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserInfo()
    }
    
    
    // Function that will fetch data on user whose email was used to log in
    func fetchUserInfo(){
        
        let db = Firestore.firestore()
        db.collection("users").whereField("Email", isEqualTo: userEmail).getDocuments {
            (snapshot, error) in if error != nil {
                
                print(error!)
            } else {
                
                for document in (snapshot?.documents)! {
                    
                    if let userFirstName = document.data()["First Name"] as? String{
                        
                        self.userFirstNameLabel.text = userFirstName
                        print(userFirstName)
                    }
                    
                }
            }
            
        }
        
        
        
        
    }
    
    
    
}
