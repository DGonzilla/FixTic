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



class CheckStatusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var ticketsTableView: UITableView!
    
        
    
    
    // Declares variables to be used
    var userEmail = ""
    var userFirstName = ""
    var userLastName = ""
    var userType = ""
    
    
    // Declares database
    let db = Firestore.firestore()
    
    

    let ticketCategoryDataTest = ["Hardware","Application Issue", "Password Reset", "Email Issue", "Connectivity", "Other"]
    var selectedTicketCategory = ""
    
    let ticketStatusDataTest = ["Completed", "In Progress", "Open", "Completed", "In Progress", "Open"]
    var selectedTicketStatus = ""
    
    let ticketDateDataTest = ["11/10", "11/27", "12/23", "12/29", "01/02", "01/05"]
    var selectedTicketDate = ""
    
    let ticketTechnicianTest = ["Adrien Gonzalez", "Milene Anjos", "Josh Butler", "Adam Bastille", "Chep Rodriguez", "Tony Stark"]
    var selectedTicketTechnician = ""
    
    var selectedTicketTechnicianNotes = "The application has been relaunched and passwords have been reset. You are now able to log in successfully. Please submit another ticket if issue persists."
    
    
    
    
    // Functions used for tableview ////////////////////////////////////
    
    // How many rows populate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ticketCategoryDataTest.count
    }
    
    // What happens within each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ticketsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CheckStatusTableViewCell

        cell?.cellDelegate = self
        cell?.index = indexPath
        
        cell?.ticketCategoryLabel.text = ticketCategoryDataTest[indexPath.row]
        cell?.ticketStatusLabel.text = ticketStatusDataTest[indexPath.row]
        cell?.ticketDateLabel.text = ticketDateDataTest[indexPath.row]

        return(cell!)
    }

    
    
    
    // Styling features of cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete{
            print("Delete")
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print ("CheckStatus loaded with info: ", userFirstName, userLastName, userType, userEmail)
        
        
        
        
    }
    
    
    
    // Segues back to Student Main View Controller
    @IBAction func returnToStudentMain(_ sender: UIButton) {
        
        performSegue(withIdentifier: "CheckStatusReturnToStudentMainViewSegue", sender: self)
        
    }
    
    
    
    
    // Sends SubmitTicketViewController the user's information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        // Sends studentTicketMoreInfoViewController the user's information //////////
        if segue.identifier == "StudentTicketMoreInfoSegue" {
            
            
            let studentTicketMoreInfoViewController = segue.destination as! StudentTicketMoreInfoViewController
            studentTicketMoreInfoViewController.selectedTicketCategory = selectedTicketCategory
            studentTicketMoreInfoViewController.selectedTicketStatus = selectedTicketStatus
            studentTicketMoreInfoViewController.selectedTicketDate = selectedTicketDate
            studentTicketMoreInfoViewController.selectedTicketTechnician = selectedTicketTechnician
            studentTicketMoreInfoViewController.selectedTicketTechnicianNotes = selectedTicketTechnicianNotes
            
            studentTicketMoreInfoViewController.userEmail = userEmail
            studentTicketMoreInfoViewController.userFirstName = userFirstName
            studentTicketMoreInfoViewController.userLastName = userLastName
            studentTicketMoreInfoViewController.userType = userType
        }
        
        // Sends StudentMainViewController the user's information //////////
        if segue.identifier == "CheckStatusReturnToStudentMainViewSegue" {
            
            
            let studentMainViewController = segue.destination as! StudentMainViewController
            studentMainViewController.userEmail = userEmail
            studentMainViewController.userFirstName = userFirstName
            studentMainViewController.userLastName = userLastName
            studentMainViewController.userType = userType
        }
    }
        
    }
    
    
    


// When more info arrow button is pressed, the following executes
extension CheckStatusViewController: TableViewNew {
    
    func onClickCell(index: Int) {
        print("\(index) is clicked")
        
        // Selected data is stored and segues to next View Controller
        selectedTicketCategory = ticketCategoryDataTest[index]
        selectedTicketStatus = ticketStatusDataTest[index]
        selectedTicketDate = ticketDateDataTest[index]
        selectedTicketTechnician = ticketTechnicianTest[index]
        
        
        performSegue(withIdentifier: "StudentTicketMoreInfoSegue", sender: self)
        
    }
    
    
}
