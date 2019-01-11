//
//  RunReportViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 01/09/19.
//  Copyright © 2018 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore



class RunReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Declares openTicketsTableView
    @IBOutlet weak var openTicketsTableView: UITableView!
    
    
    
    
    
    // Declares variables to be used
    var techUserEmail = ""
    var techUserFirstName = ""
    var techUserLastName = ""
    
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
    
    var selectedTicketStudentNotesFromDatabase = [String]()
    var selectedTicketStudentNotes = ""
    
    var selectedTicketDocIdFromDatabase = [String]()
    var selectedTicketDocId = ""
    
    
    
    
    
    
    
    
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
        
        db.collection("fix_tickets").whereField("Ticket Status", isEqualTo: "Open").getDocuments{
            (snapshot, error) in if error != nil {
                // prints error if issue arises
                print(error!)
            } else {
                
                for document in (snapshot?.documents)!{
                    
                    
                    ///// Queries the categories assigned to student
                    if let ticketCategoryFromDatabase = document.data()["Category"] as? String{
                        
                        // Saves queried categories into an array
                        self.ticketCategoryFromDatabase.append(ticketCategoryFromDatabase)
                        
                        ///// Queries the technician assigned to ticket
                        if let selectedTicketTechnicianFromDatabase = document.data()["Assigned Technician Name"] as? String{
                            
                            // Saves queried ticket technician into an array
                            self.selectedTicketTechnicianFromDatabase.append(selectedTicketTechnicianFromDatabase)
                            
                            ///// Queries the ticket status assigned to ticket
                            if let ticketStatusFromDatabase = document.data()["Ticket Status"] as? String{
                                
                                // Saves queried ticket statuses into an array
                                self.ticketStatusFromDatabase.append(ticketStatusFromDatabase)
                                
                                ///// Queries the date assigned to ticket
                                if let ticketDateFromDatabase = document.data()["Date Submitted"] as? String{
                                    
                                    // Saves queried ticket dates into an array
                                    self.ticketDateFromDatabase.append(ticketDateFromDatabase)
                                    
                                    ///// Queries the student notes assigned to ticket
                                    if let selectedTicketStudentNotesFromDatabase = document.data()["Description"] as? String{
                                        
                                        // Saves queried technician notes into an array
                                        self.selectedTicketStudentNotesFromDatabase.append(selectedTicketStudentNotesFromDatabase)
                                        
                                        
                                        ///// Queries the document Id assigned to ticket
                                        if let selectedTicketDocIdFromDatabase = document.documentID as? String {
                                            
                                            // Saves queried doc ID into an array
                                            self.selectedTicketDocIdFromDatabase.append(selectedTicketDocIdFromDatabase)
      
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Data has been fetched | Reloads tableView to update table data
                self.openTicketsTableView.reloadData()
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
        
        let cell = openTicketsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RunReportsTableViewCell
        
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
        if segue.identifier == "TechTicketMoreInfoSegue" {
            
            
            let techTicketMoreInfoViewController = segue.destination as! TechTicketMoreInfoViewController
            techTicketMoreInfoViewController.techUserEmail = techUserEmail
            techTicketMoreInfoViewController.techUserFirstName = techUserFirstName
            techTicketMoreInfoViewController.techUserLastName = techUserLastName
            
            techTicketMoreInfoViewController.userEmail = userEmail
            techTicketMoreInfoViewController.userFirstName = userFirstName
            techTicketMoreInfoViewController.userLastName = userLastName
            techTicketMoreInfoViewController.userType = userType
            
            techTicketMoreInfoViewController.selectedTicketCategory = selectedTicketCategory
            techTicketMoreInfoViewController.selectedTicketDate = selectedTicketDate
            techTicketMoreInfoViewController.selectedTicketStatus = selectedTicketStatus
            techTicketMoreInfoViewController.selectedTicketTechnician = selectedTicketTechnician
            techTicketMoreInfoViewController.selectedTicketStudentNotes = selectedTicketStudentNotes
            techTicketMoreInfoViewController.selectedTicketDocId = selectedTicketDocId
        }
        
        // Sends TechMainViewController the user's information //////////
        if segue.identifier == "RunReportReturnToTechMainViewSegue" {
            
            
            let techMainViewController = segue.destination as! TechMainViewController
            techMainViewController.techUserEmail = techUserEmail
            techMainViewController.techUserFirstName = techUserFirstName
            techMainViewController.techUserLastName = techUserLastName
            techMainViewController.userType = userType
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    // Segues back to Tech Main View Controller
    @IBAction func returnToTechMain(_ sender: UIButton) {
        
        performSegue(withIdentifier: "RunReportReturnToTechMainViewSegue", sender: self)
    }
}





// When more info arrow button is pressed, the following executes
extension RunReportViewController: TableTechViewNew {
    
    func onClickCell(index: Int) {
        print("\(index) is clicked")
        print("So far so good!!")
        
        // Selected data is stored and segues to next View Controller
        selectedTicketCategory = ticketCategoryFromDatabase[index]
        selectedTicketDate = ticketDateFromDatabase[index]
        selectedTicketStatus = ticketStatusFromDatabase[index]
        selectedTicketTechnician = "Open"
        selectedTicketStudentNotes = selectedTicketStudentNotesFromDatabase[index]
        selectedTicketDocId = selectedTicketDocIdFromDatabase[index]
        
        
        
        
        performSegue(withIdentifier: "TechTicketMoreInfoSegue", sender: self)
    }
}

