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
    
    // Declares ticketTableView
    @IBOutlet weak var ticketsTableView: UITableView!
    
    
    
    
    // Declares variables to be used
    var userEmail = ""
    var userFirstName = ""
    var userLastName = ""
    var userType = ""
    
    var ticketCategoryFromDatabase = [String]()
    var selectedTicketCategory = ""
    
    var selectedTicketTechnicianFromDatabase = [String]()
    var selectedTicketTechnician = ""
    
    var ticketStatusFromDatabase = [String]()
    var selectedTicketStatus = ""
    
    var ticketDateFromDatabase = [String]()
    var selectedTicketDate = ""
    
    var selectedTicketTechnicianNotesFromDatabase = [String]()
    var selectedTicketTechnicianNotes = ""
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        fetchTicketInfo()
    }
    
    
    
    
    
    
    
    // Function that will fetch ticket data on user whose email was used to log in
    func fetchTicketInfo(){
        
        // Declares database
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        db.collection("fix_tickets").whereField("Student Username", isEqualTo: userEmail).getDocuments{
            (snapshot, error) in if error != nil {
                // prints error if issue arises
                print(error!)
            } else {
                
                for document in (snapshot?.documents)!{
                    
                    /// Queries the categories assigned to student
                    if let ticketCategoryFromDatabase = document.data()["Category"] as? String{
                        
                        // Saves queried categories into an array
                        self.ticketCategoryFromDatabase.append(ticketCategoryFromDatabase)
                        
                        /// Queries the technician assigned to ticket
                        if let selectedTicketTechnicianFromDatabase = document.data()["Assigned Technician Username"] as? String{
                            
                            // Saves queried ticket technician into an array
                            self.selectedTicketTechnicianFromDatabase.append(selectedTicketTechnicianFromDatabase)
                            
                            /// Queries the ticket status assigned to ticket
                            if let ticketStatusFromDatabase = document.data()["Ticket Status"] as? String{
                                
                                // Saves queried ticket statuses into an array
                                self.ticketStatusFromDatabase.append(ticketStatusFromDatabase)
                                
                                /// Queries the date assigned to ticket
                                if let ticketDateFromDatabase = document.data()["Date Submitted"] as? String{
                                    
                                    // Saves queried ticket dates into an array
                                    self.ticketDateFromDatabase.append(ticketDateFromDatabase)
                                    
                                    /// Queries the technician notes assigned to ticket
                                    if let selectedTicketTechnicianNotesFromDatabase = document.data()["Technician Notes"] as? String{
                                        
                                        // Saves queried technician notes into an array
                                        self.selectedTicketTechnicianNotesFromDatabase.append(selectedTicketTechnicianNotesFromDatabase)
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Data has been fetched | Reloads tableView to update table data
                self.ticketsTableView.reloadData()
            }
        }
    }
    
    
    
   
    
    
    // Functions used for tableview ////////////////////////////////////
    
    // How many rows populate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return ticketCategoryFromDatabase.count
    }
    
    // What happens within each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ticketsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CheckStatusTableViewCell
        
        cell?.cellDelegate = self
        cell?.index = indexPath
        
        cell?.ticketCategoryLabel.text = ticketCategoryFromDatabase[indexPath.row]
        cell?.ticketStatusLabel.text = ticketStatusFromDatabase[indexPath.row]
        cell?.ticketDateLabel.text = ticketDateFromDatabase[indexPath.row]
        
        return(cell!)
    }
    
    
    
    
    
    // Segues to SubmitTicketViewController with the user's information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Sends studentTicketMoreInfoViewController the user's information //////////
        if segue.identifier == "StudentTicketMoreInfoSegue" {
            
            
            let studentTicketMoreInfoViewController = segue.destination as! StudentTicketMoreInfoViewController
            studentTicketMoreInfoViewController.userEmail = userEmail
            studentTicketMoreInfoViewController.userFirstName = userFirstName
            studentTicketMoreInfoViewController.userLastName = userLastName
            studentTicketMoreInfoViewController.userType = userType
            
            studentTicketMoreInfoViewController.selectedTicketCategory = selectedTicketCategory
            studentTicketMoreInfoViewController.selectedTicketDate = selectedTicketDate
            studentTicketMoreInfoViewController.selectedTicketStatus = selectedTicketStatus
            studentTicketMoreInfoViewController.selectedTicketTechnician = selectedTicketTechnician
            studentTicketMoreInfoViewController.selectedTicketTechnicianNotes = selectedTicketTechnicianNotes
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
    
    
    
    // Segues back to Student Main View Controller
    @IBAction func returnToStudentMain(_ sender: UIButton) {
        
        performSegue(withIdentifier: "CheckStatusReturnToStudentMainViewSegue", sender: self)
    }
}





// When more info arrow button is pressed, the following executes
extension CheckStatusViewController: TableViewNew {
    
    func onClickCell(index: Int) {
        print("\(index) is clicked")
        
        // Selected data is stored and segues to next View Controller
        selectedTicketCategory = ticketCategoryFromDatabase[index]
        selectedTicketDate = ticketDateFromDatabase[index]
        selectedTicketStatus = ticketStatusFromDatabase[index]
        selectedTicketTechnician = selectedTicketTechnicianFromDatabase[index]
        selectedTicketTechnicianNotes = selectedTicketTechnicianNotesFromDatabase[index]
        
        
        performSegue(withIdentifier: "StudentTicketMoreInfoSegue", sender: self)
    }
}

