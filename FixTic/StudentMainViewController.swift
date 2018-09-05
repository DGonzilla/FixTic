//
//  StudentMainViewController.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 7/14/18.
//  Copyright © 2018 David Adrien Gonzalez. All rights reserved.
// 

import UIKit
import Firebase
import FirebaseFirestore

class StudentMainViewController: UIViewController {
    
    // Wiring for objects
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBAction func checkStatusButton(_ sender: UIButton) {
    }
    
    @IBAction func submitFixTicButton(_ sender: UIButton) {
    }
    
    
    var firstName = String()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameLabel.text = firstName
    }
    

    

}
