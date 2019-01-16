//
//  ViewAllTicketsTechMoreInfoViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 1/5/19.
//  Copyright © 2019 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore



class ViewAllTicketsTechMoreInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var ticketCategoryLabel: UILabel!
    @IBOutlet weak var ticketDateLabel: UILabel!
    @IBOutlet weak var ticketStatusLabel: UILabel!
    @IBOutlet weak var ticketTechAssignedLabel: UILabel!
    
    @IBOutlet weak var technicianTicketNotes: UITextView!
    
    
    
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
    
    
    @IBOutlet weak var updateTicket: UIButton!
    @IBOutlet weak var closeTicket: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(techUserEmail)
        
        
        
        self.technicianTicketNotes.delegate = self
        
        
        
        self.ticketCategoryLabel.text = selectedTicketCategory
        self.ticketStatusLabel.text = selectedTicketStatus
        self.ticketDateLabel.text = selectedTicketDate
        self.ticketTechAssignedLabel.text = selectedTicketTechnician
        self.technicianTicketNotes.text = selectedTicketStudentNotes
        
        technicianTicketNotes.textColor = .lightGray
        
        
        // Hides UIButtons if the status of the ticket is mark completed
        if (selectedTicketStatus == "Completed"){
            
            updateTicket.isHidden = true
            closeTicket.isHidden = true
            technicianTicketNotes.isEditable = false
        }
        
    }
    
    
    
    
    
    @IBAction func updateTicket(_ sender: UIButton) {
        
        
        
        // Declares database
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        if (technicianTicketNotes.textColor == .lightGray){
            
            print("Technician notes have not changed. Please update notes before pressing update button")
            performSegue(withIdentifier: "modifiedTicketErrorSegue", sender: self)
        }
        else {
            
            // Writes info to database updating the ticket notes
            db.collection("fix_tickets").document(selectedTicketDocId).updateData(["Technician Notes" : technicianTicketNotes.text!, "Description" : technicianTicketNotes.text!])
            
            // Transitions to updateTicketSegue
            performSegue(withIdentifier: "updateTicketSegue", sender: self)
        }
        
        
    }
    
    
    @IBAction func closeTicket(_ sender: UIButton) {
        
        
        
        
        // Declares database
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        
        
        if (technicianTicketNotes.textColor == .lightGray){
            
            print(technicianTicketNotes.text!)
            print("Technician notes have not changed. Please update notes before pressing close button")
            performSegue(withIdentifier: "modifiedTicketErrorSegue", sender: self)
        }
        else {
            
            
            // Writes info to database updating the ticket notes
            db.collection("fix_tickets").document(selectedTicketDocId).updateData(["Technician Notes" : technicianTicketNotes.text!, "Description" : technicianTicketNotes.text!, "Ticket Status" : "Completed"])
            
            
            // Transitions to closeTicketSegue
            performSegue(withIdentifier: "closeTicketSegue", sender: self)
        }
        
    }
    
    
    
    
    
    
    
    
    
    // Prepares variables for segue back to ReturnToViewAllTicketsTechSegue or to TechConfirmationViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Sends StudentMainViewController the user's information //////////
        if segue.identifier == "ReturnToViewAllTicketsTechSegue" {
            
            
            let viewAllTicketsTechViewController = segue.destination as! ViewAllTicketsTechViewController
            viewAllTicketsTechViewController.techUserEmail = techUserEmail
            viewAllTicketsTechViewController.techUserFirstName = techUserFirstName
            viewAllTicketsTechViewController.techUserLastName = techUserLastName
            viewAllTicketsTechViewController.userType = userType
        }
        
                if segue.identifier == "updateTicketSegue" {
        
                    let techModifiedTicketViewController = segue.destination as! TechModifiedTicketViewController
                    techModifiedTicketViewController.techUserEmail = techUserEmail
                    techModifiedTicketViewController.techUserFirstName = techUserFirstName
                    techModifiedTicketViewController.techUserLastName = techUserLastName
                    techModifiedTicketViewController.userType = userType
                    techModifiedTicketViewController.confirmationMessageLabel = "Thank you for the update!"
                }
                if segue.identifier == "closeTicketSegue" {
        
                    let techModifiedTicketViewController = segue.destination as! TechModifiedTicketViewController
                    techModifiedTicketViewController.techUserEmail = techUserEmail
                    techModifiedTicketViewController.techUserFirstName = techUserFirstName
                    techModifiedTicketViewController.techUserLastName = techUserLastName
                    techModifiedTicketViewController.userType = userType
                    techModifiedTicketViewController.confirmationMessageLabel = "This ticket is now closed.\nThank you for fixing this ticket!"
                }
        
                if segue.identifier == "modifiedTicketErrorSegue" {
        
                    let techModifiedTicketErrorViewController = segue.destination as! TechModifiedTicketErrorViewController
                    techModifiedTicketErrorViewController.techUserEmail = techUserEmail
                    techModifiedTicketErrorViewController.techUserFirstName = techUserFirstName
                    techModifiedTicketErrorViewController.techUserLastName = techUserLastName
                    techModifiedTicketErrorViewController.userType = userType
                }
    }
    
    
    
    
    
    
    
    
    
    
    /////////////////   Keyboard Functions ////////////////////////
    
    
    //*** Hides keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    
    // Raises view when keyboard is called
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 225, width:self.view.frame.size.width, height:self.view.frame.size.height);
        })
    }
    
    
    
    // Lowers view when finished using keyboard
    func textFieldDidEndEditing(_ textField: UITextField,
                                reason: UITextField.DidEndEditingReason){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 225, width:self.view.frame.size.width, height:self.view.frame.size.height);        })
    }
    
    
    
    // Raises view when keyboard is called for TextView ////////////////
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        
        // Animation to raise keyboard
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 225, width:self.view.frame.size.width, height:self.view.frame.size.height);
        })
        
        
        // Placeholder for technicianTicketNotes
        if (technicianTicketNotes.text == selectedTicketStudentNotes
            && technicianTicketNotes.textColor == .lightGray)
        {
            technicianTicketNotes.text = ""
            technicianTicketNotes.textColor = .black
        }
        technicianTicketNotes.becomeFirstResponder()
        
    }
    
    
    // Lowers view when finished using keyboard for TextView
    func textViewDidEndEditing(_ textView: UITextView) {
        
        // Animation to lower keyboard
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 225, width:self.view.frame.size.width, height:self.view.frame.size.height);        })
        
        
        // Placeholder for technicianTicketNotes when nothing within textfield
        if (technicianTicketNotes.text == ""){
            
            technicianTicketNotes.text = selectedTicketStudentNotes
            technicianTicketNotes.textColor = .lightGray
        }
        
        technicianTicketNotes.resignFirstResponder()
    }
    
    /////////////////   Keyboard Functions Ending ////////////////////////
    
    
}

