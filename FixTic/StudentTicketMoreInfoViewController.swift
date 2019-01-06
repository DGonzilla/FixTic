//
//  StudentTicketMoreInfoViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 1/5/19.
//  Copyright © 2019 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore



class StudentTicketMoreInfoViewController: UIViewController {
    
    @IBOutlet weak var ticketCategoryLabel: UILabel!
    @IBOutlet weak var ticketDateLabel: UILabel!
    @IBOutlet weak var ticketStatusLabel: UILabel!
    @IBOutlet weak var ticketTechAssignedLabel: UILabel!
    
    @IBOutlet weak var technicianTicketNotes: UITextView!
    
    
    // Declares all variables used
    var userEmail = ""
    var userFirstName = ""
    var userLastName = ""
    var userType = ""
    
    var selectedTicketCategory = ""
    var selectedTicketStatus = ""
    var selectedTicketDate = ""
    var selectedTicketTechnician = ""
    var selectedTicketTechnicianNotes = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.ticketCategoryLabel.text = selectedTicketCategory
        self.ticketStatusLabel.text = selectedTicketStatus
        self.ticketDateLabel.text = selectedTicketDate
        self.ticketTechAssignedLabel.text = selectedTicketTechnician
        self.technicianTicketNotes.text = selectedTicketTechnicianNotes
        
        
    }
    
    
    
    @IBAction func returnToCheckStatus(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ReturnToCheckAllTicketsSegue", sender: self)
        
    }
    
    
    
    
    
    
    // Prepares variable for segue back to CheckStatusViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Sends StudentMainViewController the user's information //////////
        if segue.identifier == "ReturnToCheckAllTicketsSegue" {
            
            
            let checkStatusViewController = segue.destination as! CheckStatusViewController
            checkStatusViewController.userEmail = userEmail
            checkStatusViewController.userFirstName = userFirstName
            checkStatusViewController.userLastName = userLastName
            checkStatusViewController.userType = userType
        }
        
    }
    
}

