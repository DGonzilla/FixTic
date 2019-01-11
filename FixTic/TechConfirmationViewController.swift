//
//  TechConfirmationViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 1/10/19.
//  Copyright © 2019 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore



class TechConfirmationViewController: UIViewController {
    
    
    
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
        
        print(selectedTicketDocId)
        
        
    }
    
    
    
    
    
    @IBAction func returnToTicketsButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "returnToOpenTicketsTestSegue", sender: self)
    }
    
    
    
    
    
    
    
    
    
    // Prepares variable for segue back to ReturnToTechRunReportsSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Sends StudentMainViewController the user's information //////////
        if segue.identifier == "returnToOpenTicketsTestSegue" {
            
            
            let runReportViewController = segue.destination as! RunReportViewController
            runReportViewController.techUserEmail = techUserEmail
            runReportViewController.techUserFirstName = techUserFirstName
            runReportViewController.techUserLastName = techUserLastName
            runReportViewController.userType = userType
            
            
        }
        
    }
    
    
    
    
}

