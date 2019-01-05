//
//  CheckStatusTableViewCell.swift
//  FixTic
//
//  Created by David Adrien Gonzalez on 12/29/18.
//  Copyright © 2018 David Adrien Gonzalez. All rights reserved.
//

import UIKit

class CheckStatusTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ticketDateLabel: UILabel!
    @IBOutlet weak var ticketCategoryLabel: UILabel!
    @IBOutlet weak var ticketStatusLabel: UILabel!
    
    @IBAction func ticketMoreInfoArrowButton(_ sender: UIButton) {
        print("More Info Button Pressed :))))")
    }
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
