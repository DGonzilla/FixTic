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
    
    

    let data = ["Hardware", "Connectivity", "Password"]
    
    
    
    
    
    
    
    
    
    // Functions used for tableview ////////////////////////////////////
    
    // How many rows populate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    // What happens within each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ticketsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CheckStatusTableViewCell

        
        cell?.ticketCategoryLabel.text = data[indexPath.row]
        return(cell!)
    }

    // Styling features of cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete{
            print("Delete")
        }
    }
    ////////////////////////////////////////////////////////////////////
    
    
    

    
    
    
    
    
    @IBAction func returnToStudentMain(_ sender: UIButton) {
        
        performSegue(withIdentifier: "CheckStatusReturnToStudentMainViewSegue", sender: self)
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    // Sends StudentMainViewController the user's information //////////
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CheckStatusReturnToStudentMainViewSegue" {
            
            
            let studentMainViewController = segue.destination as! StudentMainViewController
            studentMainViewController.userEmail = userEmail
            studentMainViewController.userFirstName = userFirstName
            studentMainViewController.userLastName = userLastName
            studentMainViewController.userType = userType
        }
    }
    ////////////////////////////////////////////////////////////////////
    
    
}


