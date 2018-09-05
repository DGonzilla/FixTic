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
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBAction func runReportButton(_ sender: UIButton) {
    }
    @IBAction func viewTicketsButton(_ sender: UIButton) {
    }
    
    
    var firstName = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLabel.text = firstName
    }
    

    

}
