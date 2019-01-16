//
//  TechTicketMoreInfoViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 1/5/19.
//  Copyright © 2019 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore



class TechTicketMoreInfoViewController: UIViewController {
    
    @IBOutlet weak var ticketCategoryLabel: UILabel!
    @IBOutlet weak var ticketDateLabel: UILabel!
    @IBOutlet weak var ticketStatusLabel: UILabel!
    @IBOutlet weak var ticketTechAssignedLabel: UILabel!
    
    @IBOutlet weak var studentTicketNotes: UITextView!
    
    
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
        
        
        
        self.ticketCategoryLabel.text = selectedTicketCategory
        self.ticketStatusLabel.text = selectedTicketStatus
        self.ticketDateLabel.text = selectedTicketDate
        self.ticketTechAssignedLabel.text = selectedTicketTechnician
        self.studentTicketNotes.text = selectedTicketStudentNotes
        
    }
    
    
    @IBAction func returnToTechRunReports(_ sender: UIButton) {
        
         performSegue(withIdentifier: "ReturnToTechRunReportsSegue", sender: self)
    }
    
    
    
    
    @IBAction func fixIssue(_ sender: UIButton) {
        
        print("Confirming tech name is stored")
        print(techUserFirstName, techUserLastName)
        
        // Declares database
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        
        // Writes info to database updating the ticket status and assigned technician
        db.collection("fix_tickets").document(selectedTicketDocId).updateData(["Ticket Status" : "In Progress", "Assigned Technician Name" : "\(techUserFirstName) \(techUserLastName)"])
        
        
        
        performSegue(withIdentifier: "TechConfirmationSegue", sender: self)
    }
    
    
    
    
    
    // Prepares variables for segue back to ReturnToTechRunReportsSegue or to TechConfirmationViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Sends StudentMainViewController the user's information //////////
        if segue.identifier == "ReturnToTechRunReportsSegue" {
            
            
            let runReportViewController = segue.destination as! RunReportViewController
            runReportViewController.techUserEmail = techUserEmail
            runReportViewController.techUserFirstName = techUserFirstName
            runReportViewController.techUserLastName = techUserLastName
            runReportViewController.userType = userType
        }
        
        if segue.identifier == "TechConfirmationSegue" {
            
            let techConfirmationViewController = segue.destination as! TechConfirmationViewController
            techConfirmationViewController.techUserEmail = techUserEmail
            techConfirmationViewController.techUserFirstName = techUserFirstName
            techConfirmationViewController.techUserLastName = techUserLastName
            techConfirmationViewController.userType = userType
        }
        
    }
    
    
}

