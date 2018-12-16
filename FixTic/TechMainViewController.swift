//
//  TechMainViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 7/14/18.
//  Copyright © 2018 David Adrien Gonzalez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class TechMainViewController: UIViewController {

    
    
    // Wires all view objects
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBAction func runReportButton(_ sender: UIButton) {
    }
    @IBAction func viewTicketsButton(_ sender: UIButton) {
    }
    
    
    var userFirstName = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userFirstNameLabel.text = userFirstName
    }
    

    

}
