//
//  TechModifiedTicketViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 1/10/19.
//  Copyright © 2019 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore



class TechModifiedTicketViewController: UIViewController {
    
    
    
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
    
    var confirmationMessageLabel = ""
    

    
    @IBOutlet weak var confirmationMessage: UILabel!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        confirmationMessage.text = confirmationMessageLabel
        
}



    @IBAction func returnToTickets(_ sender: UIButton) {
    
    
        
        performSegue(withIdentifier: "returnToViewAllTicketsSegue", sender: self)
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

