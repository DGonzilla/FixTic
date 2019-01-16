//
//  TechModifiedTicketErrorViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 1/13/19.
//  Copyright © 2019 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore



class TechModifiedTicketErrorViewController: UIViewController{
    
    
    // Declares all variables used
    var techUserEmail = ""
    var techUserFirstName = ""
    var techUserLastName = ""
    
    var userEmail = ""
    var userFirstName = ""
    var userLastName = ""
    var userType = ""
    
    var selectedTicketCategory = ""
    var selectedTicketStatus = ""
    var selectedTicketDate = ""
    var selectedTicketTechnician = ""
    var selectedTicketStudentNotes = ""
    var selectedTicketDocId = ""
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(techUserEmail)
        
        
        
        
        
        
        
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Sends StudentMainViewController the user's information //////////
        if segue.identifier == "returnToViewAllTicketsSegue" {
            
            
            let viewAllTicketsTechViewController = segue.destination as! ViewAllTicketsTechViewController
            viewAllTicketsTechViewController.techUserEmail = techUserEmail
            viewAllTicketsTechViewController.techUserFirstName = techUserFirstName
            viewAllTicketsTechViewController.techUserLastName = techUserLastName
            viewAllTicketsTechViewController.userType = userType
            viewAllTicketsTechViewController.selectedTicketDocId = selectedTicketDocId
            
        }
        
    }
    
    
    
    
}
